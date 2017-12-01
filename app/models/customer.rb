class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants
    .select('merchants.*, sum(transactions.id) AS num_transactions')
    .joins(invoices: [:transactions, :merchant])
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('num_transactions desc')
    .limit(1)
    .first
  end

  def self.pending_invoices_to_merchant(merchant_id)
    merchant_id = merchant_id.to_i
    find_by_sql("SELECT invoices.* FROM invoices WHERE invoices.merchant_id=#{merchant_id} EXCEPT SELECT invoices.* FROM invoices INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE transactions.result='success'")
  end

end
