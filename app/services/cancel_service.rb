class CancelService
  include RespondService

  def call(game)
    return success(I18n.t('cancel_service.no_active_games')) if game.nil?

    game.update!(state: :canceled)

    answer = game.question.answer

    success(I18n.t('cancel_service.game_canceled', answer:))
  rescue StandardError => e
    failure(e)
  end
end
