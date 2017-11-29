require 'rails_helper'

describe "Merchants API" do
  describe "get /api/v1/merchants/:id/revenue" do
    it "returns the revenue associated with a merchant" do

      merchant = create(:merchant)
      item1 = create(:item, unit_price: 10000)
      item2 = create(:item, unit_price: 20012)
      item3 = create(:item, unit_price: 2500)
      merchant.items << [item1, item2, item3]
<<<<<<< HEAD
      invoice1 = create(:invoice, status: 'shipped', merchant: merchant)
      invoice2 = create(:invoice, status: 'shipped', merchant: merchant)
      invoice3 = create(:invoice, status: 'shipped', merchant: merchant)
=======
      invoice1 = create(:invoice, status: 'shipped')
      invoice2 = create(:invoice, status: 'shipped')
      invoice3 = create(:invoice, status: 'shipped')
>>>>>>> c44e19d0bf4e71f7777f9fd7f1ce8ab0f9e31db5
      item1.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 3, unit_price: item1.unit_price)
      item1.invoice_items << create(:invoice_item, invoice: invoice2, quantity: 2, unit_price: item1.unit_price)
      item2.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 1, unit_price: item2.unit_price)
      item3.invoice_items << create(:invoice_item, invoice: invoice3, quantity: 1, unit_price: item3.unit_price)
      transaction1 = create(:transaction, invoice: invoice1, result: 'success')
      transaction2 = create(:transaction, invoice: invoice2, result: 'success')
      transaction3 = create(:transaction, invoice: invoice3, result: 'failed')

<<<<<<< HEAD
=======
      require "pry"; binding.pry
>>>>>>> c44e19d0bf4e71f7777f9fd7f1ce8ab0f9e31db5
      get "/api/v1/merchants/#{merchant.id}/revenue"

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(revenue).to have_key(:revenue)
<<<<<<< HEAD
      expect(revenue[:revenue]).to eq("700.12")
=======
      expect(revenue[:revenue]).to eq(700.12)
>>>>>>> c44e19d0bf4e71f7777f9fd7f1ce8ab0f9e31db5
    end
  end
end
