class CancelService
  include RespondService

  def call(game)
    return success('No games to cancel') if game.nil?

    game.update!(state: :canceled)

    success('Game canceled')
  rescue StandardError => e
    failure(e)
  end
end
