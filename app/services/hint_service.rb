class HintService
  include RespondService

  def call(game)
    return success(I18n.t('hint_service.no_active_games')) if game.nil?

    begin
      hint = game.question.hints.offset(game.hints_count).take!
    rescue ActiveRecord::RecordNotFound
      begin
        game_client = ChatGptGameClient.new(Rails.application.secrets.chat_gpt_token)
        text = game_client.generate_hint(game.question)
      rescue StandardError => e
        return failure(e)
      end

      hint = Hint.create(text:, question_id: game.question.id)
    rescue StandardError => e
      return failure(e)
    end

    game.increment!(:hints_count, 1)

    success(hint.text)
  end
end
