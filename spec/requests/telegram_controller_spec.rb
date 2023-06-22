require 'rails_helper'

RSpec.describe TelegramController, type: :request do
  it 'should return success' do
    allow(TelegramBotJob).to receive(:perform)

    params = { message: { text: 'message', chat: { id: 123 }, from: 'user' } }

    post('/telegram', params:, as: :json)

    expect(response).to be_successful

    expect(TelegramBotJob).to have_received(:perform).once.with(Rails.application.secrets.tg_bot_token, params[:message][:text], params[:message][:chat][:id], params[:message][:from])
  end
end
