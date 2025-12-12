# frozen_string_literal: true

# Protects /telegram/* endpoints using X-Telegram-Secret header.

require "active_support/security_utils"

class TelegramSecretAuth
  def initialize(app)
    @app = app
  end

  def call(env)
    req = ActionDispatch::Request.new(env)

    if req.path.start_with?("/telegram/")
      expected = ENV["TELEGRAM_WEBHOOK_SECRET"].to_s
      provided = req.get_header("HTTP_X_TELEGRAM_SECRET").to_s

      return unauthorized unless valid_secret?(provided, expected)
    end

    @app.call(env)
  end

  private

  def valid_secret?(provided, expected)
    return false if expected.empty? || provided.empty?
    return false unless provided.bytesize == expected.bytesize
    ActiveSupport::SecurityUtils.secure_compare(provided, expected)
  end

  def unauthorized
    body = { error: "unauthorized" }.to_json
    [401, { "Content-Type" => "application/json" }, [body]]
  end
end

