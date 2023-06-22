class TelegramIndexForm
  def self.build_params(params)
    telegram_user = params.dig(:message, :from)

    {
      message: params.dig(:message, :text),
      chat_id: params.dig(:message, :chat, :id),
      telegram_id: telegram_user['id'],
      first_name: telegram_user['first_name'],
      last_name: telegram_user['last_name'],
      username: telegram_user['username'],
      locale: telegram_user['language_code']
    }
  end
end
