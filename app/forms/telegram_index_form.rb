class TelegramIndexForm
  def self.build_params(params)
    {
      message: params.dig(:message, :text),
      chat_id: params.dig(:message, :chat, :id),
      telegram_id: params.dig(:message, :from, :id),
      first_name: params.dig(:message, :from, :first_name),
      last_name: params.dig(:message, :from, :last_name),
      username: params.dig(:message, :from, :username),
      locale: params.dig(:message, :from, :language_code)
    }
  end
end
