FactoryBot.define do
  factory :hint, class: 'Hint' do
    text { 'Hint text' }
    association :question
  end
end
