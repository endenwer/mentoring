class ProfileService
  include RespondService

  def call(user)
    profile_info = I18n.t('profile_service.profile_info',
                          telegram_id: user.telegram_id,
                          username: user.username,
                          first_name: user.first_name,
                          last_name: user.last_name,
                          games_finished: user.games.finished.size,
                          games_canceled: user.games.canceled.size)
    success(profile_info)
  end
end
