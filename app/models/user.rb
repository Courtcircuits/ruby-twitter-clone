class User < ApplicationRecord
  include BCrypt
  has_secure_password
  has_many :tweets
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
end
