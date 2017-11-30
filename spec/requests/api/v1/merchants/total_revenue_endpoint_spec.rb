require 'rails_helper'

RSpec.describe "can return the total revenue across all merchants" do
  it "with no date" do
    invoice1, invoice2, invoice3 = create_list(:invoice, 3)
    item = create(:item)
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, quantity: 4, unit_price: 500)
    invoice_item2 = create(:invoice_item, invoice: invoice2, item: item, quantity: 6, unit_price: 700)
    invoice_item3 = create(:invoice_item, invoice: invoice3, item: item, quantity: 10, unit_price: 400)

    total1 = invoice_item1.quantity * invoice_item1.unit_price
    total2 = invoice_item2.quantity * invoice_item2.unit_price
    total3 = invoice_item3.quantity * invoice_item3.unit_price
    total = total1 + total2 + total3
    
    get '/api/v1/merchants/revenue'
    result = JSON.parse(response)

    expect(response).to be_success
    expect(result[:revenue]).to eq(total.to_s)
  end

end
