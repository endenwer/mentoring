class TelegramController < ApplicationController
  def index
    TelegramBotJob.perform(Rails.application.secrets.tg_bot_token, params)

    render json: { status: 'ok' }
  end
end
