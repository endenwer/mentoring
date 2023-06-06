class Game < ApplicationRecord
  belongs_to :user
  belongs_to :question

  enum state: { active: 0, finished: 1, canceled: 2 }
end
