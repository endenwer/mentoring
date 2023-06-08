class AnswerService
  include RespondService

  def call(game, answer)
    @game = game
    @question = game.question

    return correct_answer if @question.answer == answer

    incorrect_answer
  end

  private

  def correct_answer
    @game.update!(state: :finished)

    hints_count = @question.hints.size
    hints_text = hints_count.positive? ? " But i give you #{hints_count} hints" : ''

    success("You are winner!#{hints_text}")
  rescue StandardError => e
    failure(e)
  end

  def incorrect_answer
    success('Wrong answer, try again or type /hint')
  end
end
