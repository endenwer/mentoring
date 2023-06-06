class HintService
  include RespondService

  def call(game)
    return success('Type /play to start a game') if game.nil?

    hint = Hint.new(text: 'Its a hint', question_id: game.question.id)
    hint.save!

    success(hint.text)
  rescue StandardError => e
    failure(e)
  end
end
