class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices

  def favorite_customer
    Customer.left_joins(invoices: :transactions)
    .group('customers.id')
    .where(invoices: { merchant_id: id })
    .merge(Transaction.successful)
    .order('count(transactions.id) DESC')
    .first
  end

end
