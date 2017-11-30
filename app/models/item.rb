class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  before_create :format_unit_price

  def self.most_sold_items(quantity = 5)
    select('items.*, sum(invoice_items.quantity) as total_sold')
    .joins(:invoices)
    .group(:id)
    .order('total_sold desc').limit(quantity)
  end

  private

  def format_unit_price
    self.unit_price = (self.unit_price.to_f / 100).round(2)
  end
end
