class TelegramController < ApplicationController
  def index
    Rails.application.secrets.tg_bot_token
    render json: { status: 'ok' }
  end
end
