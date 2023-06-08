class GenerateQuestionService
  OPENAI_API_KEY = Rails.application.secrets.chatgpt_token

  def call
    begin
      question = send_message("Generate me please question for trivia game. Question:")
      answer = send_message("Generate me please answer for this question. Question: #{question} Answer:")

      new_question = Question.new(
        text: question,
        answer: answer
      )
      new_question.save
      new_question
    rescue StandardError => e
      Rails.logger.error("Error occurred while generating question: #{e.message}")
    end
  end

  private

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

    Rails.logger.info("Response received: #{content}")

    content
  end
end
