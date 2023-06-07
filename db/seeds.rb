Question.destroy_all
Answer.destroy_all
Hint.destroy_all

data = [
  { question: '1 + 1 = ?', answer: '2', hint: '2' },
  { question: '1 + 2 = ?', answer: '3', hint: '3' },
  { question: '1 + 3 = ?', answer: '4', hint: '4' },
  { question: '1 + 4 = ?', answer: '5', hint: '5' },
  { question: '1 + 5 = ?', answer: '6', hint: '6' },
  { question: '1 + 6 = ?', answer: '7', hint: '7' },
  { question: '1 + 7 = ?', answer: '8', hint: '8' },
  { question: '1 + 8 = ?', answer: '9', hint: '9' },
  { question: '1 + 9 = ?', answer: '10', hint: '10' },
  { question: '2 + 1 = ?', answer: '2', hint: '3' },
  { question: '2 + 2 = ?', answer: '4', hint: '4' },
  { question: '2 + 3 = ?', answer: '5', hint: '5' },
  { question: '2 + 4 = ?', answer: '6', hint: '6' },
  { question: '2 + 5 = ?', answer: '7', hint: '7' },
  { question: '2 + 6 = ?', answer: '8', hint: '8' },
  { question: '2 + 7 = ?', answer: '9', hint: '9' },
  { question: '2 + 8 = ?', answer: '10', hint: '10' },
  { question: '2 + 9 = ?', answer: '11', hint: '11' },
  { question: '3 + 1 = ?', answer: '4', hint: '4' },
  { question: '3 + 2 = ?', answer: '5', hint: '5' },
  { question: '3 + 3 = ?', answer: '6', hint: '6' },
  { question: '3 + 4 = ?', answer: '7', hint: '7' },
  { question: '3 + 5 = ?', answer: '8', hint: '8' },
  { question: '3 + 6 = ?', answer: '9', hint: '9' },
  { question: '3 + 7 = ?', answer: '10', hint: '10' },
  { question: '3 + 8 = ?', answer: '11', hint: '11' },
  { question: '3 + 9 = ?', answer: '12', hint: '12' }
]

data.map do |q|
  question = Question.create(text: q[:question])
  Answer.create(text: q[:answer], question_id: question.id)
  Hint.create(text: q[:hint], question_id: question.id)
end
