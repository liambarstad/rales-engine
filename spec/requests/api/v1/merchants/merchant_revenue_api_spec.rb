require 'rails_helper'

describe "Merchants API" do
  describe "get /api/v1/merchants/:id/revenue" do
    it "returns the revenue associated with a merchant" do

      merchant = create(:merchant)
      item1 = create(:item, unit_price: 10000)
      item2 = create(:item, unit_price: 20012)
      item3 = create(:item, unit_price: 2500)
      merchant.items << [item1, item2, item3]
      invoice1 = create(:invoice, status: 'shipped', merchant: merchant)
      invoice2 = create(:invoice, status: 'shipped', merchant: merchant)
      invoice3 = create(:invoice, status: 'shipped', merchant: merchant)
      item1.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 3, unit_price: item1.unit_price)
      item1.invoice_items << create(:invoice_item, invoice: invoice2, quantity: 2, unit_price: item1.unit_price)
      item2.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 1, unit_price: item2.unit_price)
      item3.invoice_items << create(:invoice_item, invoice: invoice3, quantity: 1, unit_price: item3.unit_price)
      transaction1 = create(:transaction, invoice: invoice1, result: 'success')
      transaction2 = create(:transaction, invoice: invoice2, result: 'success')
      transaction3 = create(:transaction, invoice: invoice3, result: 'failed')

      get "/api/v1/merchants/#{merchant.id}/revenue"

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(revenue).to have_key(:revenue)
      expect(revenue[:revenue]).to eq(700.12)
    end
  end
end
