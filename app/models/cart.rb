class Cart < ApplicationRecord
  has_many :cart_items

  def total_amount
    total_amount = 0
    self.cart_items.each do |cart_item|
      total_amount += cart_item.item.price
    end
    total_amount
  end
end
