class TelegramController < ApplicationController
  def index
    TelegramBotJob.perform_later(params)

    render json: { status: 'ok' }
  end
end
