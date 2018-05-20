class AddImageNameToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :image_name, :string
  end
end
