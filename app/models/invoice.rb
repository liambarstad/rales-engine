class Invoice < ApplicationRecord

  belongs_to :merchant
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  
  def self.total_revenue(date)
    left_joins(:invoice_items)
    .where(created_at: date)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

end
