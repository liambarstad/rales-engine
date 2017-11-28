class ChangeNameColumnonMerchants < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    change_column :merchants, :name, :citext
  end
end
