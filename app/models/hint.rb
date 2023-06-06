class Hint < ApplicationRecord
  belongs_to :question

  enum state: { unused: 0, used: 1 }
end
