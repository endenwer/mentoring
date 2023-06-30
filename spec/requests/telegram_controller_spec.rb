require 'rails_helper'

RSpec.describe TelegramController, type: :request do
  it 'should return success' do
    allow(TelegramBotJob).to receive(:perform_async)

    params = {
      message: { text: 'message', chat: { id: 123 },
                 from: { id: 321, first_name: 'Mike', last_name: 'Vazovsky', username: 'mike_vazovsky', language_code: 'en' } }
    }

    form = TelegramIndexForm.build_params(params)

    post('/telegram', params:)

    expect(response).to be_successful

    expect(TelegramBotJob).to have_received(:perform_async).once.with(
      Rails.application.secrets.tg_bot_token,
      form[:message],
      form[:chat_id],
      form[:telegram_id],
      form[:first_name],
      form[:last_name],
      form[:username],
      form[:locale]
    )
  end
end
