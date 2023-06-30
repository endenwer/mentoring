class TelegramController < ApplicationController
  def index
    form = TelegramIndexForm.build_params(params)

    TelegramBotJob.perform_async(
      Rails.application.secrets.tg_bot_token,
      form[:message],
      form[:chat_id],
      form[:telegram_id],
      form[:first_name],
      form[:last_name],
      form[:username],
      form[:locale]
    )

    render json: { status: 'ok' }
  end
end
