class TelegramBotCommands
  private

  def start(update, user, chat_id)
    return send_message(chat_id, "Hello, #{user.first_name} #{user.last_name}") if user.present?

    begin
      from = from_user(update)
      new_user = User.new(telegram_id: from['id'], first_name: from['first_name'], last_name: from['last_name'],
                          username: from['username'])
      new_user.save!
      send_message(chat_id, "Profile created, you`r welcome, #{new_user.first_name} #{new_user.last_name}")
    rescue StandardError
      error_message(chat_id)
    end
  end

  def profile(user, chat_id)
    profile_info = "Telegram ID: #{user.telegram_id}, Username: #{user.username}, Fullname: #{user.first_name} #{user.last_name}"
    send_message(chat_id, profile_info)
  end

  def unknown(chat_id)
    send_message(chat_id, 'Unknown command')
  end

  def ping(chat_id)
    send_message(chat_id, 'pong')
  end
end
