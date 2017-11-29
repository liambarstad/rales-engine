class ChangeFirstNameToCitextOnCustomers < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    change_column :customers, :first_name, :citext
  end
end
