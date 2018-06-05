class Item < ApplicationRecord
  # TODO remove column images
  has_many :reviews
  belongs_to :user
  has_one_attached :photo

  validates :name, :price, :description, presence: true
  validates :name, uniqueness: true

  def score
    if self.reviews.present?
      self.reviews.average(:score).floor(1).to_f
    else
      0
    end
  end
end
