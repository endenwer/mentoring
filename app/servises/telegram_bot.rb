class TelegramBot < GameCommands
  def initialize(token)
    @token = token
  end

  def call(update)
    message_text = update['message'] && update['message']['text'] && update['message']['text']
    is_command = message_text.start_with?('/')
    is_answer = !is_command

    user = find_user_by_id(update)
    chat_id = user_chat_id(update)
    command = update['message']['text'].split(' ')[0]
    game = find_active_game(user) if ['/play', '/hint', '/cancel'].include?(command) || is_answer

    return answer(game, chat_id, message_text) if is_answer

    return send_message(chat_id, 'Type /start to create profile') if user.nil? && ['/start', '/ping'].include?(command)

    case command
    when '/start'
      start(update, user, chat_id)
    when '/profile'
      profile(user, chat_id)
    when '/ping'
      ping(chat_id)
    when '/play'
      play(user, game, chat_id)
    when '/hint'
      hint(game, chat_id)
    when '/cancel'
      cancel(game, chat_id)
    else
      unknown(chat_id)
    end
  end

  def send_message(chat_id, text)
    HTTParty.post(
      "https://api.telegram.org/bot#{@token}/sendMessage",
      body: { chat_id:, text: }
    )
  end

  def error_message(chat_id)
    send_message(chat_id, 'Something went wrong')
  end

  def find_user_by_id(update)
    user_id = from_user(update)['id']
    User.find_by(telegram_id: user_id)
  end

  def find_active_game(user)
    games = user.games.where(is_active: true)
    games[0]
  end

  def from_user(update)
    update['message']['from']
  end

  def user_chat_id(update)
    update['message']['chat']['id']
  end
end
