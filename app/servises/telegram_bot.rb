class TelegramBot
  def initialize(token)
    @token = token
  end

  def call(update)
    return unless update['message'] && update['message']['text'] && update['message']['text'].start_with?('/')

    command = update['message']['text'].split(' ')[0]
    case command
    when '/start'
      start(update)
    when '/profile'
      profile(update)
    when '/ping'
      ping(update)
    when '/game'
      game(update)
    else
      unknown(update)
    end
  end

  private

  def start(update)
    chat_id = user_chat_id(update)

    begin
      user = find_user_by_id(update)
      send_message(chat_id, "Hello, #{user.first_name} #{user.last_name}")
    rescue ActiveRecord::RecordNotFound
      from = from_user(update)
      new_user = User.new(telegram_id: from['id'], first_name: from['first_name'], last_name: from['last_name'],
                          username: from['username'])
      new_user.save!
      send_message(chat_id, "Profile created, you`r welcome, #{new_user.first_name} #{new_user.last_name}")
    rescue StandardError
      error_message(chat_id)
    end
  end

  def profile(update)
    chat_id = user_chat_id(update)

    begin
      user = find_user_by_id(update)
      profile_info = "Telegram ID: #{user.telegram_id}, Username: #{user.username}, Fullname: #{user.first_name} #{user.last_name}"
      send_message(chat_id, profile_info)
    rescue ActiveRecord::RecordNotFound
      send_message(chat_id, 'Type /start to create profile')
    rescue StandardError
      error_message(chat_id)
    end
  end

  def select_new_question(user_id)
    played_questions = Game.where(user_id: user_id).map { |game| game.question_id }
  
    unplayed_questions = Question.all.reject { |question| played_questions.include?(question.id) }
  
    unplayed_questions.sample
  end


  def game(update)    
    chat_id = user_chat_id(update)
    
    begin
      user = find_user_by_id(update)    
      question = select_new_question(user.id)
  
      game = Game.new(user_id: user.id, question_id: question.id)
      if game.save
        send_message(chat_id, 'Game started')
        send_message(chat_id, question.text)
      else
        send_message(chat_id, 'Game could not be saved. Please try again.')
      end
    rescue ActiveRecord::RecordNotFound => e
      send_message(chat_id, 'Profile not found, type /start to create profile')
    rescue StandardError => e
      error_message(chat_id)
    end
  end
  

  def unknown(update)
    chat_id = user_chat_id(update)
    send_message(chat_id, 'Unknown command')
  end

  def ping(update)
    chat_id = user_chat_id(update)
    send_message(chat_id, 'pong')
  end

  def send_message(chat_id, text)
    HTTParty.post(
      "https://api.telegram.org/bot#{@token}/sendMessage",
      body: { chat_id:, text: }
    )
  end

  def find_user_by_id(update)
    user_id = from_user(update)['id']
    User.find_by!(telegram_id: user_id)
  end

  def from_user(update)
    update['message']['from']
  end

  def user_chat_id(update)
    update['message']['chat']['id']
  end

  def error_message(chat_id)
    send_message(chat_id, 'Something went wrong')
  end
end
