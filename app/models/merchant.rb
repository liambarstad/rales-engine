class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices

  def favorite_customer
    Customer.left_joins(invoices: :transactions)
    .group('customers.id')
    .where(invoices: { merchant_id: id }, transactions: { result: 'success' })
    .order('count(transactions.id)')
    .first
  end

end
