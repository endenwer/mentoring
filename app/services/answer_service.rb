class AnswerService
  include RespondService

  def call(game, answer)
    @game = game
    @question = game.question

    begin
      game_client = ChatGptGameClient.new(Rails.application.secrets.chat_gpt_token)
      is_correct_answer = game_client.check_is_correct_answer(@question, answer)
    rescue StandardError => e
      return failure(e)
    end

    return correct_answer if is_correct_answer

    incorrect_answer
  rescue StandardError => e
    failure(e)
  end

  private

  def correct_answer
    @game.update!(state: :finished)

    success(I18n.t('answer_service.correct_answer_success', hints_text:))
  rescue StandardError => e
    failure(e)
  end

  def incorrect_answer
    success(I18n.t('answer_service.incorrect_answer_success'))
  end

  def hints_text
    hints_count = @game.hints_count

    I18n.t('answer_service.hints_text', hints_count:) if hints_count.positive?
  end
end
