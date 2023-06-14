class LocaleService
  include RespondService

  LOCALES = %i[en ru].freeze

  def update_user_locale(db_user, locale)
    if LOCALES.include?(locale)
      change_locale(locale)

      db_user.update(locale:)

      success(I18n.t('locale_service.locale_changed'))
    else
      success(I18n.t('locale_service.unsupported_locale'))
    end
  end

  def change_locale(locale)
    I18n.locale = locale
  end
end
