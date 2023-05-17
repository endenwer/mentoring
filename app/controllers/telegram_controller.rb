class TelegramController < ApplicationController
  def index
    bot = TelegramBot.new(Rails.application.secrets.tg_bot_token)
    bot.call(params)
    render json: { status: 'ok' }
  end
end
