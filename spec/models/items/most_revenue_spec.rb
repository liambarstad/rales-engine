require 'rails_helper'

RSpec.feature "model can output items by total revenue" do
  it "with arguement" do
    item1, item2, item3 = create_list(:item, 3)
    invoice1, invoice2, invoice3 = create_list(:invoice, 3)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 2, unit_price: 500)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice2, unit_price: 700)
    invoice_item3 = create(:invoice_item, item: item3, invoice: invoice3, unit_price: 2000)
    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'failed')

    item = Item.by_revenue(1)

    expect(item[0].id).to eq(item1.id)
  end
end
