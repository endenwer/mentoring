FactoryBot.define do
  factory :game, class: 'Game' do
    state { 0 }
    hints_count { 0 }
    association :user
    association :question
  end
end
