class ChangeNameToCitextOnItems < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    change_column :items, :name, :citext
  end
end
