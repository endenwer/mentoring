Question.destroy_all
Hint.destroy_all

data = [
  { question: '1 + 1 = ?', answer: '2', hint: '2' },
  { question: '1 + 2 = ?', answer: '3', hint: '3' },
  { question: '1 + 3 = ?', answer: '4', hint: '4' }
]

data.map do |q|
  question = Question.create(text: q[:question], answer: q[:answer])
  Hint.create(text: q[:hint], question_id: question.id)
end
