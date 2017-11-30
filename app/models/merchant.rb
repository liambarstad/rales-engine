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
    Invoice.total_revenue(date)
  end

  def self.by_revenue(quantity)
    quantity ||= 1
    left_joins(invoices: [:invoice_items, :transactions])
    .group('merchants.id')
    .merge(Transaction.successful)
    .order('sum(invoice_items.unit_price * invoice_items.quantity) DESC')
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) as total_sold')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .reorder('total_sold desc')
    .limit(quantity)
  end

end
