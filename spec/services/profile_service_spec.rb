RSpec.describe ProfileService do
  it 'successfully show profile info' do
    user = build(:user)
    response = described_class.new.call(user)

    profile_info = I18n.t(
      'profile_service.profile_info',
      telegram_id: user.telegram_id,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name,
      games_finished: user.games.finished.size,
      games_canceled: user.games.canceled.size
    )

    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(profile_info)
  end
end
