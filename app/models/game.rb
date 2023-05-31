class Game < ApplicationRecord
  belongs_to :user
  has_one :question
  has_many :hints

  enum state: { active: 0, finished: 1 }

  scope :is_active, -> { where(state: :active) }
end
