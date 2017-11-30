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

  def self.total_revenue(date)
    Invoice
    .left_joins(:invoice_items, :transactions)
    .where(transactions: { result: 'success', created_at: date })
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.by_revenue(quantity = 1)
    left_joins(invoices: [:invoice_items, :transactions])
    .group('merchants.id')
    .merge(Transaction.successful)
    .order('sum(invoice_items.unit_price * invoice_items.quantity) DESC')
    .limit(quantity)
  end

end
