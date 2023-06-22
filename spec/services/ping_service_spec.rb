require 'rails_helper'

RSpec.describe PingService do
  let(:response) { described_class.new.call }

  it 'ping method return message:pong' do
    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq('pong')
  end
end
