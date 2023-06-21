class AnswerService
  include RespondService
  OPENAI_API_KEY = Rails.application.secrets.chatgpt_token

  def call(game, answer)
    @game = game
    @question = game.question
    @question_answer = @question.answer
    
    if accept_answer?(answer, @question.text, @question_answer)
      correct_answer
    else
      incorrect_answer
    end

  rescue StandardError => e
    failure(e)
  end

  private

  def accept_answer?(answer, question_text, question_answer)
    message = "Is this user provided answer correct? Question: #{question_text}; RightAnswer: #{question_answer} UserProvidedAnswer: #{answer}"
    response = send_message(message)
    parse_response(response)
  end

  def correct_answer
    @game.update!(state: :finished)

    hints_count = @question.hints.size
    hints_text = hints_count.positive? ? " But I gave you #{hints_count} hints" : ''

    success("You are the winner!#{hints_text}")
  end

  def incorrect_answer
    success("Wrong answer, try again or type /hint")
  end

  def send_message(message)

    response = HTTParty.post(
      "https://api.openai.com/v1/chat/completions",
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{OPENAI_API_KEY}"
      },
      body: {
        "model" => "gpt-3.5-turbo",
        "messages" => [{ "role" => "user", "content" => message }]
      }.to_json
    )

    choices = JSON.parse(response.body)["choices"]
    content = choices.first["message"]["content"]


    content
  end

  def parse_response(response)
    response.downcase.strip.include?("yes")
  end
end
