require 'rails_helper'

RSpec.feature "merchant class can order by revenue" do
  it "with no arguement" do
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant3)
    invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 2, unit_price: 500)
    invoice_item2 = create(:invoice_item, invoice: invoice2, unit_price: 700)
    invoice_item3 = create(:invoice_item, invoice: invoice3, unit_price: 2000)
    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'failed')

    top_merchant = Merchant.by_revenue(1)

    expect(top_merchant.to_a.count).to eq(1)
    expect(top_merchant.first.id).to eq(merchant1.id)
  end

  it "with arguement" do
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant3)
    invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 2, unit_price: 500)
    invoice_item2 = create(:invoice_item, invoice: invoice2, unit_price: 700)
    invoice_item3 = create(:invoice_item, invoice: invoice3, unit_price: 2000)
    transaction1 = create(:transaction, invoice: invoice1, result: 'success')
    transaction2 = create(:transaction, invoice: invoice2, result: 'success')
    transaction3 = create(:transaction, invoice: invoice3, result: 'failed')

    top_merchants = Merchant.by_revenue(2)

    expect(top_merchants[0].id).to eq(merchant1.id)
    expect(top_merchants[1].id).to eq(merchant2.id)
  end
end
