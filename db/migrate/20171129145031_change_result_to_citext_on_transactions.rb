class ChangeResultToCitextOnTransactions < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    change_column :transactions, :result, :citext
  end
end
