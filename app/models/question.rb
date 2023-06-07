class Question < ApplicationRecord
  has_one :answer
  has_many :games
  has_many :hints
end
