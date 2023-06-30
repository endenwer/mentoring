FactoryBot.define do
  factory :question, class: 'Question' do
    text { 'Question text' }
    answer { 'Question answer' }
  end
end
