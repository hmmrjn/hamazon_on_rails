class TypoPurchaceToPurchaseInOrderItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :order_items, :purchace_price, :purchase_price
  end
end
