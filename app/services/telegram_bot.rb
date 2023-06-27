class TelegramBot
  attr_reader :message, :chat_id, :telegram_id, :first_name, :last_name, :username, :locale, :db_user, :command

  def initialize(token, message, chat_id, telegram_id, first_name, last_name, username, user_locale)
    @token = token
    @message = message
    @chat_id = chat_id
    @telegram_id = telegram_id
    @first_name = first_name
    @last_name = last_name
    @username = username
    @db_user = User.find_by(telegram_id:)
    @locale = db_user.present? ? db_user.locale : user_locale
    @command = message.split(' ')[0]

    ChangeLocaleService.new.call(locale)
  end

  def call
    is_command = message.start_with?('/')
    is_answer = !is_command

    return send_message(I18n.t('telegram_bot.type_start_to_create_profile')) if db_user.nil? && !['/start', '/ping'].include?(command)

    return handle_answer if is_answer

    handle_result(handle_command)
  end

  private

  def handle_command
    case command
    when '/start'
      StartService.new.call(db_user, telegram_id, first_name, last_name, username, locale)
    when '/profile'
      ProfileService.new.call(db_user)
    when '/ping'
      PingService.new.call
    when '/play'
      PlayService.new.call(db_user, game)
    when '/hint'
      HintService.new.call(game)
    when '/cancel'
      CancelService.new.call(game)
    when '/en_locale'
      UpdateUserLocaleService.new.call(db_user, :en)
    when '/ru_locale'
      UpdateUserLocaleService.new.call(db_user, :ru)
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

  def handle_answer
    if game.present?
      result = AnswerService.new.call(game, message)

      return handle_result(result)
    end

    send_message(I18n.t('telegram_bot.type_play_to_start_game'))
  end

  def handle_result(result)
    return send_message(result[:message]) if result[:is_success]

    send_message(result[:error_message])
  end

  def game
    @game ||= db_user.games.active.take
  end
end
