class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :user
  
  validates :body, presence: true
end
