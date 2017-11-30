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

  def revenue
    invoices
    .joins(:transactions, :invoice_items)
    .merge(Transaction.successful)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.total_revenue(date = nil)
    Invoice
    .left_joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

end
