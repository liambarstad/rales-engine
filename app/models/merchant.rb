class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def favorite_customer
    Customer.left_joins(invoices: :transactions)
    .group('customers.id')
    .where(invoices: { merchant_id: id })
    .merge(Transaction.successful)
    .order('count(transactions.id) DESC')
    .first
  end

  def revenue(date = nil)
    if date
      invoices
      .joins(:transactions, :invoice_items)
      .where(invoices: {created_at: date})
      .merge(Transaction.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
    else
      invoices
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum('invoice_items.quantity * invoice_items.unit_price')
    end
  end

  def customers_with_pending_invoices
    pending_invoices = invoices.joins(:transactions)
    .where.not(transactions: { result: 'success' })
    .pluck(:customer_id)
    Customer.find(pending_invoices)
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
