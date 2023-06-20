class GenerateHintService
  OPENAI_API_KEY = Rails.application.secrets.chatgpt_token

  def call(game)
    begin
      question = game.question.text
      answer =  game.question.answer
      hint = send_message("Generate me please hint for this question. Question: #{question}; Answer: #{answer}; Hint:")
      
      new_hint = Hint.new(
        question_id:  game.question.id,
        text: answer
      )
      new_hint.save
      new_hint
    rescue StandardError => e
      Rails.logger.error("Error occurred while generating hint: #{e.message}")
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
