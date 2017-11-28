class AddInvoiceRelationships < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :merchant, foreign_key: true, index: true
    add_reference :invoices, :customer, foreign_key: true, index: true
  end
end
