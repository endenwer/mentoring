class TelegramBot
  def initialize(token)
    @token = token
  end

  def call(update)
    @update = update

    message_text = update['message'] && update['message']['text']
    command = message_text.split(' ')[0]
    is_command = message_text.start_with?('/')
    is_answer = !is_command

    return send_message('Type /start to create profile') if user.nil? && !['/start', '/ping'].include?(command)

    return handle_answer(message_text) if is_answer

    result = handle_command(command)

    handle_result(result)
  end

  private

  def handle_command(command)
    case command
    when '/start'
      StartService.new.call(user, from_user)
    when '/profile'
      ProfileService.new.call(user)
    when '/ping'
      PingService.new.call
    when '/play'
      PlayService.new.call(user, game)
    when '/hint'
      HintService.new.call(game)
    when '/cancel'
      CancelService.new.call(game)
    else
      UnknownService.new.call
    end
  end

  def send_message(text)
    HTTParty.post(
      "https://api.telegram.org/bot#{@token}/sendMessage",
      body: { chat_id:, text: }
    )
  end

  def handle_answer(message_text)
    if game.present?
      result = AnswerService.new.call(game, message_text)

      return handle_result(result)
    end

    send_message('Type /play to start a new game')
  end

  def handle_result(result)
    return send_message(result[:message]) if result[:is_success]

    send_message(result[:error_message])
  end

  def user
    user_id = from_user['id']
    @user ||= User.find_by(telegram_id: user_id)
  end

  def from_user
    @from_user ||= @update['message']['from']
  end

  def chat_id
    @chat_id ||= @update['message']['chat']['id']
  end

  def game
    @game ||= user.games.active[0]
  end
end
