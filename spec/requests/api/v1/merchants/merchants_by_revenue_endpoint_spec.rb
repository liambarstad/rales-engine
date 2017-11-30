require 'rails_helper'

RSpec.describe "can get merchants by revenue" do
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
    get '/api/v1/merchants/most_revenue'
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(1)
    expect(result[0]["id"]).to eq(top_merchant.first.id)
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
    get '/api/v1/merchants/most_revenue?quantity=2'
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
    expect(result[0]["id"]).to eq(top_merchants[0].id)
    expect(result[1]["id"]).to eq(top_merchants[1].id)
  end
end
