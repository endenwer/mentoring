class ChatGptGameClient
  def initialize(token)
    @token = token
  end

  def generate_question_and_answer
    question = generate_question
    answer = generate_answer(question)

    { question:, answer: }
  end

  def generate_hint(question)
    hints_text = question.hints.present? ? I18n.t('game_client.generate_hint.hints_present_text', hints: stringify_hints(question.hints)) : I18n.t('game_client.generate_hint.no_hints_text')

    send_message(I18n.t('game_client.generate_hint.message', question: question.text, answer: question.answer, hints_text:))
  end

  def check_is_correct_answer(question, user_answer)
    response = send_message(I18n.t('game_client.check_is_correct_answer.message', question: question.text, answer: question.answer, user_answer:))
    content = response.downcase

    return true if content.include?(I18n.t('game_client.check_is_correct_answer.yes_answer'))
    return false if content.include?(I18n.t('game_client.check_is_correct_answer.no_answer'))

    raise StandardError, I18n.t('game_client.check_is_correct_answer.try_rephrasing')
  end

  private

  def generate_question
    send_message(I18n.t('game_client.generate_question.message'))
  end

  def generate_answer(question_text)
    send_message(I18n.t('game_client.generate_answer.message', question_text:))
  end

  def get_success_response_content(response)
    response.parsed_response['choices'][0]['message']['content']
  end

  def get_fail_response_content(response)
    response.parsed_response['error']['message']
  end

  def stringify_hints(hints)
    hints_array = hints.pluck(:text)
    hints_array.join(', ').gsub('.', '')
  end

  def send_message(message)
    response = HTTParty.post(
      'https://api.openai.com/v1/chat/completions',
      body: { model: 'gpt-3.5-turbo', messages: [{ role: 'user', content: message }] }.to_json,
      headers: { Authorization: "Bearer #{@token}", "Content-Type": 'application/json' }
    )

    return get_success_response_content(response) if response.code == 200

    raise StandardError, get_fail_response_content(response)
  end
end
