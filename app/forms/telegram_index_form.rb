class TelegramIndexForm
  def self.build_params(params)
    {
      message: params.dig(:message, :text),
      chat_id: params.dig(:message, :chat, :id),
      telegram_user: params.dig(:message, :from)
    }
  end
end
