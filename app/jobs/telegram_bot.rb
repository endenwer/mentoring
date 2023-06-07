class TelegramBotJob < ApplicationJob
    queue_as :default

    def perform(params)
        bot = TelegramBot.new(Rails.application.secrets.tg_bot_token)
        bot.call(params)
    end
end