# frozen_string_literal: true

require "json"

class Telegram::UpdatesController < ApplicationController
  def create
    update = JSON.parse(request.raw_post) # Parse raw JSON body

    # Support both formats:
    # 1) { "message": {...} }
    # 2) { "chat": {...}, "text": "..."}  (message-only payload)
    message = update["message"] || update

    return render(json: { actions: [] }) if message["chat"].nil?

    chat_id = message.dig("chat", "id")
    text    = message["text"].to_s

    actions = if text.start_with?("/start")
      [{ method: "send_message", params: { chat_id: chat_id, text: "Hi! I'm Rails brain 👋" } }]
    else
      [{ method: "send_message", params: { chat_id: chat_id, text: "Rails got: #{text}" } }]
    end

    render json: { actions: actions }
  rescue JSON::ParserError
    render json: { actions: [] }, status: :bad_request
  end
end

