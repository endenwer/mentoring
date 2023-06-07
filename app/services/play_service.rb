class PlayService
  include RespondService

  def call(user, game)
    return success(game.question.text) if game.present?

    question = Question.where.not(id: answered_questions(user)).take!

    Game.create(user_id: user.id, question_id: question.id)

    success(question.text)
  rescue ActiveRecord::RecordNotFound
    success('No more questions')
  rescue StandardError => e
    failure(e)
  end

  private

  def answered_questions(user)
    user.games.pluck(:question_id)
  end
end
