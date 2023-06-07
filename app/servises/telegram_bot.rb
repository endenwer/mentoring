require_relative 'helpers/user_helper'
require_relative 'helpers/game_helper'
require_relative 'helpers/message_helper'
require_relative 'helpers/game_status_helper'

class TelegramBot
  include UserHelper
  include GameHelper
  include MessageHelper
  include GameStatusHelper

  def initialize(token)
    @token = token
  end

  def call(update)
    if update['message'] && update['message']['text'] && update['message']['text'].start_with?('/')
      handle_command(update)
    else 
      handle_message(update)
    end
  end

  private

  def handle_command(update)
    command = update['message']['text'].split(' ')[0]
    case command
    when '/start'
      start(update)
    when '/profile'
      profile(update)
    when '/ping'
      ping(update)
    when '/game'
      game(update) unless check_game_availability(user_chat_id(update), find_user_by_id(update).id)
    when '/cancel'
      cancel(update)
    when '/hint'
      hint(update)
    else
      unknown(update)
    end
  end

  def start(update)
    chat_id = user_chat_id(update)

    begin
      user = find_user_by_id(update)
      send_message(chat_id, "Hello, #{user.first_name} #{user.last_name}")
    rescue ActiveRecord::RecordNotFound
      from = from_user(update)
      new_user = User.create!(telegram_id: from['id'], first_name: from['first_name'], last_name: from['last_name'],
                          username: from['username'])
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

  def game(update)    
    chat_id = user_chat_id(update)
  
    begin
      user = find_user_by_id(update)
  
      current_games = Game.where(user_id: user.id, status: :active)
      if current_games.length > 0 
        send_message(chat_id, 'You already playing')
        return
      end
  
      question = select_new_question(user.id)
      game = Game.new(user_id: user.id, question_id: question.id, status: :active )
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
  

  def cancel(update)
    chat_id = user_chat_id(update)
    begin
      user = find_user_by_id(update)    
      current_game = active_game(user.id)
      if current_game
        current_game.update!(status: :canceled)
        send_message(chat_id, 'Game canceled')
      else
        send_message(chat_id, 'You dont have current games, try to create one, type /game')
      end
    rescue ActiveRecord::RecordNotFound => e
      send_message(chat_id, 'Profile not found, type /start to create profile')
    rescue StandardError => e
      error_message(chat_id)
    end
  end

  def hint(update)
    chat_id = user_chat_id(update)
    begin
      user = find_user_by_id(update)
      current_game = active_game(user.id)
      if current_game
        current_game.increment!(:hints_count)
        send_message(chat_id, 'hint')
      else
        send_message(chat_id, 'You dont have current games, try to create one, type /game')
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

  def handle_message(update) 
    chat_id = user_chat_id(update)
    user = find_user_by_id(update)
  
    message = update['message']['text']
    current_game = active_game(user.id)
    if current_game 
      answer(chat_id, current_game, message)
    end
  end
  
  def answer(chat_id, current_game, message)
    question = Question.find(current_game.question_id)
    if question.answer == message
      send_message(chat_id, '💥 Hell Yeah 💥')
      current_game.update!(status: :ended)
    else
      send_message(chat_id, 'Wrong!')
    end
  end
end
