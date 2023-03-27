class Spot < ApplicationRecord
  belongs_to :user
  
  serialize :image_url, Array
  has_many :reviews, dependent: :destroy
  
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true
end
