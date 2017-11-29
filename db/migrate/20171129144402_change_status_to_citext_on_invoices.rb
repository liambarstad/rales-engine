class ChangeStatusToCitextOnInvoices < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'citext'

    change_column :invoices, :status, :citext
  end
end
