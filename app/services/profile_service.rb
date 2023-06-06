class ProfileService
  include RespondService

  def call(user)
    profile_info = "Telegram ID: #{user.telegram_id}, Username: #{user.username}, Fullname: #{user.first_name} #{user.last_name}, Games finished: #{user.games.finished.size}, Games canceled: #{user.games.canceled.size}"

    success(profile_info)
  end
end
