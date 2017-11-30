class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope -> { order(:id) }

  before_create :format_unit_price

  def self.most_sold_items(quantity = 5)
    select('items.*, sum(invoice_items.quantity) as total_sold')
    .joins(:invoices)
    .group(:id)
    .order('total_sold desc').limit(quantity)
  end

  def best_day
    invoices
    .select('invoices.created_at, count(invoices.created_at) as number_of_sales')
    .joins(:transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order('number_of_sales desc')
    .order('invoices.created_at desc')
    .first
    .created_at
  end

  private

  def format_unit_price
    self.unit_price = (self.unit_price.to_f / 100).round(2)
  end
end
