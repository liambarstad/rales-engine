class RenameItemDescription < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :decription
    add_column :items, :description, :string
  end
end
