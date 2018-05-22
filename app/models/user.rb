class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :reviews
  has_many :items

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
