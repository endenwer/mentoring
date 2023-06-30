RSpec.describe CancelService do
  it 'no game to cancel' do
    response = described_class.new.call(nil)

    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(I18n.t('cancel_service.no_active_games'))
  end

  it 'game canceled' do
    user = create(:user)
    question = create(:question)
    game = create(:game, user:, question:)

    answer = game.question.answer

    response = described_class.new.call(game)

    expect(game.state).to eq('canceled')
    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(I18n.t('cancel_service.game_canceled', answer:))
  end
end
