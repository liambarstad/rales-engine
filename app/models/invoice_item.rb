class InvoiceItem < ApplicationRecord

  belongs_to :item
  belongs_to :invoice

  before_create :format_unit_price

  private

  def format_unit_price
    self.unit_price = (unit_price / 100).round(2)
  end

end
