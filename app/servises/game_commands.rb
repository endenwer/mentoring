class GameCommands < TelegramBotCommands
  private

  def play(user, game, chat_id)
    return send_message(chat_id, game.question.text) if game.present?

    new_game = Game.new(is_active: true, user_id: user.id)
    new_game.save!

    question = Question.new(text: 'Yes?', answer: 'Yes', game_id: new_game.id)
    question.save!

    send_message(chat_id, question.text)
  rescue StandardError
    error_message(chat_id)
  end

  def hint(game, chat_id)
    if game.present?
      begin
        hint = Hint.new(text: 'Its a hint', game_id: game.id)
        hint.save!
      rescue StandardError
        error_message(chat_id)
      end
      return send_message(chat_id, hint.text)
    end

    send_message(chat_id, 'Type /play to start a game')
  end

  def cancel(game, chat_id)
    if game.present?
      begin
        game.update!(is_active: false)
        return send_message(chat_id, 'Game canceled')
      rescue StandardError
        return error_message(chat_id)
      end
    end

    send_message(chat_id, 'No games to cancel')
  end

  def answer(game, chat_id, answer)
    return correct_answer(game, chat_id) if game.question.answer == answer

    incorrect_answer(chat_id)
  end

  def correct_answer(game, chat_id)
    game.update!(is_active: false)

    hints_count = game.hints.size
    hints_text = hints_count.positive? ? " But i give you #{hints_count} hints" : ''

    send_message(chat_id, "You are winner!#{hints_text}")
  rescue StandardError
    error_message(chat_id)
  end

  def incorrect_answer(chat_id)
    send_message(chat_id, 'Wrong, try again!')
  end
end
