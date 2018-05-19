class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :cart
      t.integer :total_amount

      t.timestamps
    end
  end
end
