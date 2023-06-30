class StartService
  include RespondService

  def call(db_user, telegram_id, first_name, last_name, username, locale)
    return success(I18n.t('start_service.profile_exists', first_name: db_user.first_name, last_name: db_user.last_name)) if db_user.present?

    begin
      new_user = User.new(telegram_id:, first_name:, last_name:, username:, locale:)
      new_user.save!

      success(I18n.t('start_service.profile_created', first_name: new_user.first_name, last_name: new_user.last_name))
    rescue StandardError => e
      failure(e)
    end
  end
end
