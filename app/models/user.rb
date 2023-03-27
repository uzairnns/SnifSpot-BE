class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows letters and digits" }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "must be a valid email address" }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true

end
