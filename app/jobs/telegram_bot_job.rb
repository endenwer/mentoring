class TelegramBotJob
  include Sidekiq::Job
  sidekiq_options queue: :default

  def perform(*args)
    TelegramBot.new(*args).call
  end
end
