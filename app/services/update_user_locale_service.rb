class UpdateUserLocaleService
  include RespondService

  LOCALES = %i[en ru].freeze

  def call(db_user, locale)
    if LOCALES.include?(locale)
      ChangeLocaleService.new.call(locale)

      db_user.update(locale:)

      success(I18n.t('locale_service.locale_changed'))
    else
      success(I18n.t('locale_service.unsupported_locale'))
    end
  end
end
