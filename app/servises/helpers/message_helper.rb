module MessageHelper
  def send_message(chat_id, text)
    HTTParty.post(
      "https://api.telegram.org/bot#{@token}/sendMessage",
      body: { chat_id:, text: }
    )
  end

  def user_chat_id(update)
    update['message']['chat']['id']
  end

  def error_message(chat_id)
    send_message(chat_id, 'Something went wrong')
  end
end
