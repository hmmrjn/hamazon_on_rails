class Item < ApplicationRecord
  has_many :reviews
  belongs_to :user

  validates :name, :price, :description, presence: true
  validates :name, uniqueness: true
end
