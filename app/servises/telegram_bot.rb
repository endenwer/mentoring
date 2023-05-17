class TelegramBot
  def initialize(token)
    @token = token
  end

  def call(update)
    if update['message'] && update['message']['text'] && update['message']['text'].start_with?('/')
      command = update['message']['text'].split(' ')[0]
      case command
      when '/start'
        # TODO: create user in db if not exists
        start(update)
      when '/profile'
        # TODO: show user profile
        start(update)
      when '/ping'
        ping(update)
      else
        unknown(update)
      end
    end
  end

  private

  def unknown(update)
    send_message(update['message']['chat']['id'], 'Unknown command')
  end

  def ping(update)
    send_message(update['message']['chat']['id'], 'pong')
  end

  def send_message(chat_id, text)
    HTTParty.post(
      "https://api.telegram.org/bot#{@token}/sendMessage",
      body: {chat_id: chat_id, text: text}
    )
  end
end
