RSpec.describe HintService do
  it 'no active games' do
    response = described_class.new.call(nil)

    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(I18n.t('hint_service.no_active_games'))
  end

  it 'create and return new hint' do
    new_hint = 'New hint'

    user = create(:user)
    question = create(:question)
    game = create(:game, user:, question:)

    allow_any_instance_of(ChatGptGameClient).to receive(:generate_hint).with(game.question).and_return(new_hint)

    response = described_class.new.call(game)

    expect(game.hints_count).to eq(1)
    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(new_hint)
  end
end
