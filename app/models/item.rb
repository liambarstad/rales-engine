class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_sold_items(quantity = 5)
    select('items.*, sum(invoice_items.quantity) as total_sold')
    .joins(:invoices)
    .group(:id)
    .order('total_sold desc').limit(quantity)
  end
end
