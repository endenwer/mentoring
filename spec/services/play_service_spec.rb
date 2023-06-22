RSpec.describe PlayService do
  let(:user) { create :user }
  it 'return success if game already present' do
    question = create(:question)
    game = create(:game, user:, question:)

    response = described_class.new.call(user, game)

    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(game.question.text)
  end

  it 'create new game and return question' do
    new_question = 'New question'
    new_answer = 'New answer'

    allow_any_instance_of(ChatGptGameClient).to receive(:generate_question_and_answer).and_return({ question: new_question, answer: new_answer })

    question = create(:question, text: new_question, answer: new_answer)
    game = create(:game, user:, question:)

    response = described_class.new.call(user, nil)

    expect(game).to be_present
    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(question.text)
  end
end
