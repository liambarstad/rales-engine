class AddTransactionsRelationships < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :invoice, foreign_key: true, index: true
  end
end
