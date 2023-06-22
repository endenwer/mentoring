# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HintService do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:game) { create(:game, question: question, user: user) }
  let!(:hint) { create(:hint, question: question) }

  it '_' do
    service_hint = described_class.new.call game
    
    expect(service_hint[:message]).to eq hint.text
  end
end
