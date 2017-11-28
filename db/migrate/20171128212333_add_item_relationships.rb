class AddItemRelationships < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :merchant, foreign_key: true, index: true
  end
end
