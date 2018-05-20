class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user, optional: true

  validates :score, :title, :content, presence: true
end
