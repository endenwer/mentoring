module GameHelper
  def select_new_question(user_id)
    played_questions = Game.where(user_id: user_id).map { |game| game.question_id }
    unplayed_questions = Question.all.reject { |question| played_questions.include?(question.id) }
    unplayed_questions.sample
  end
end
