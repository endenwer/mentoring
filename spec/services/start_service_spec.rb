RSpec.describe StartService do
  it 'user is already created' do
    db_user = create(:user)
    response = described_class.new.call(db_user, nil, nil, nil, nil, nil)

    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(
      I18n.t('start_service.profile_exists', first_name: db_user.first_name, last_name: db_user.last_name)
    )
  end

  it 'create profile for new user' do
    user = build(:user)
    response = described_class.new.call(
      nil, user.telegram_id, user.first_name, user.last_name, user.username, user.locale
    )

    expect(response[:is_success]).to be_truthy
    expect(response[:message]).to eq(
      I18n.t('start_service.profile_created', first_name: user.first_name, last_name: user.last_name)
    )
  end
end
