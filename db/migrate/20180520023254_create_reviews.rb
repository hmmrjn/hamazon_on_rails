class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :score
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
