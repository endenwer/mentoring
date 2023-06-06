class TelegramBotJob
  include Sidekiq::Job
  sidekiq_options queue: :default

  def self.perform(token, params)
    bot = TelegramBot.new(token)
    bot.call(params)
  end
end
