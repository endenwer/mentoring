class TelegramBotJob
  include Sidekiq::Job
  sidekiq_options queue: :default

  def self.perform(token, *args)
    TelegramBot.new(token, *args).call
  end
end
