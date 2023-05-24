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
        profile(update)
      when '/ping'
        ping(update)
      else
        unknown(update)
      end
    end
  end

  private

  def error(update)
    send_message(update['message']['chat']['id'], 'unexpected error')
  end

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

  def start(update)
    if update['message']['from']['is_bot']
      send_message(update['message']['chat']['id'], "-_-")
      return
    end

    userExists = User.exists?(telegram_id: update['message']['from']['id'])

    if userExists
      send_message(update['message']['chat']['id'], "Welcome back #{update['message']['from']['first_name']}")
      return
    end

    user = User.create(
      telegram_id: update['message']['from']['id'],
      first_name: update['message']['from']['first_name'],
      username: update['message']['from']['username'],
      last_name: update['message']['from']['last_name'],
    )

    if user.persisted?
      send_message(update['message']['chat']['id'], "Welcome #{update['message']['from']['first_name']}")
      return
    end

    error(update)
  end

  def profile(update)
    user = User.find_by(telegram_id: update['message']['from']['id'])

    if user.nil?
      send_message(update['message']['chat']['id'], "User not found")
      return
    end

    send_message(update['message']['chat']['id'], "User: #{user.first_name} #{user.last_name}")
  end
end
