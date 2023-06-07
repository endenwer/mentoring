class Question < ApplicationRecord
    belongs_to :game
    has_one :hint
end