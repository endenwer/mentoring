class PlayService
  include RespondService

  def call(user, game)
    return success(game.question.text) if game.present?

    question = Question.new(text: 'Yes?')
    question.save!

    answer = Answer.new(text: 'Yes', question_id: question.id)
    answer.save!

    new_game = Game.new(user_id: user.id, question_id: question.id)
    new_game.save!

    success(question.text)
  rescue StandardError => e
    failure(e)
  end
end
