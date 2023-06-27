class ChangeLocaleService
  def call(locale)
    I18n.locale = locale
  end
end
