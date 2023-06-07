class HintService
  include RespondService

  def call(game)
    return success('Type /play to start a game') if game.nil?

    hint = game.question.hints.offset(game.hints_count).take!

    game.increment!(:hints_count, 1)

    success(hint.text)
  rescue ActiveRecord::RecordNotFound
    success('No more hints')
  rescue StandardError => e
    failure(e)
  end
end
