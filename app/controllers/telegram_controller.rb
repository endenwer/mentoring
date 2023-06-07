class TelegramController < ApplicationController
  def index
    form = TelegramIndexForm.build_params(params)

    TelegramBotJob.perform(Rails.application.secrets.tg_bot_token, form[:message], form[:chat_id], form[:telegram_user])

    render json: { status: 'ok' }
  end
end
