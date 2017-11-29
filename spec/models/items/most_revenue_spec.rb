require 'rails_helper'

RSpec.feature "item can output most revenue" do
  it "with no arguement" do 
    item1, item2, item3 = create_list(:item, 3)
    invoice1 = create(:invoice, status: 'shipped')
    transaction1 = create(:transaction, invoice: invoice1, result: 'success') 
    item1.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 3, unit_price: 700)
    invoice2 = create(:invoice, status: 'shipped')
    transaction2 = create(:transaction, invoice: invoice2, result: 'failed')
    item2.invoice_items << create(:invoice_item, invoice: invoice2, quantity: 5, unit_price: 700)

    most_sold_items = Item.most_revenue

    expect(most_sold_items.to_a.count).to eq(1)
    expect(most_sold_items[0].id).to eq(item1.id)
  end

  it "with arguement" do

  end
end
