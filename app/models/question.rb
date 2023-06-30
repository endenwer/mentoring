class Question < ApplicationRecord
  has_many :games
  has_many :hints
end
