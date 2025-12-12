# frozen_string_literal: true

# Telegram bot (long polling) that forwards updates to Rails over HTTP.
# Rails returns "actions" (e.g., send_message), and the bot executes them.

require "telegram/bot"
require "faraday"
require "json"

BOT_TOKEN = ENV.fetch("TELEGRAM_BOT_TOKEN")
RAILS_URL = "http://tanym:3000/telegram/update"
SECRET   = ENV.fetch("TELEGRAM_WEBHOOK_SECRET")

http = Faraday.new do |f|
  f.options.open_timeout = 2
  f.options.timeout = 8
end

Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
  bot.listen do |update|
    # Convert update object to a plain hash
    payload = update.to_h

    begin
      resp = http.post(RAILS_URL) do |req|
        req.headers["Content-Type"] = "application/json"
        req.headers["X-Telegram-Secret"] = SECRET
        req.body = payload.to_json
      end

      if resp.status == 401
        warn "[tg-bot] Rails returned 401 Unauthorized (invalid secret)"
        next
      end

      unless resp.success?
        warn "[tg-bot] Rails error: status=#{resp.status} body=#{resp.body}"
        next
      end

      data = JSON.parse(resp.body) rescue {}
      actions = data["actions"] || []

      actions.each do |a|
        method = a["method"] # use snake_case methods for telegram-bot-ruby
        params = a["params"] || {}

        next if method.nil? || method.empty?

        # Execute Telegram API call
        bot.api.public_send(method, **params.transform_keys(&:to_sym))
      end
    rescue => e
      warn "[tg-bot] exception: #{e.class}: #{e.message}"
    end
  end
end

