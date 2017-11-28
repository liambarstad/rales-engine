class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :decription
      t.float :unit_price

      t.timestamps
    end
  end
end
