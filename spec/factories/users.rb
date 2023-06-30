FactoryBot.define do
  factory :user, class: 'User' do
    telegram_id { 1 }
    first_name { 'Mike' }
    last_name { 'Vazovsky' }
    username { 'mike_vazovsky' }
    locale { 'en' }
  end
end
