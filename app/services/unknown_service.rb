class UnknownService
  include RespondService

  def call
    success(I18n.t('unknown_service.unknown_command'))
  end
end
