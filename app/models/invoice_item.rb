class InvoiceItem < ApplicationRecord

  before_save :format_unit_price

  private

  def format_unit_price
    unit_price.insert(-3, ".")
  end

end
