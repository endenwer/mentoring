class PlayService
  include RespondService

  def call(user, game)
    begin
      return success(game.question.text) if game.present?

      question = Question.where.not(id: answered_questions(user)).take!
    rescue ActiveRecord::RecordNotFound
      begin
        game_client = ChatGptGameClient.new(Rails.application.secrets.chat_gpt_token)
        question_and_answer = game_client.generate_question_and_answer
      rescue StandardError => e
        return failure(e)
      end

      question = Question.create(text: question_and_answer[:question], answer: question_and_answer[:answer])
    rescue StandardError => e
      failure(e)
    end

    Game.create(user_id: user.id, question_id: question.id)

    success(question.text)
  end

  private

  def answered_questions(user)
    user.games.pluck(:question_id)
  end
end
