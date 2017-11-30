require 'rails_helper'

describe "Items API" do
  describe "get /api/v1/items/most_items?quantity=x" do
    it "returns the top x number of items" do
      merchant = create(:merchant)
      item1 = create(:item, name: "Item1", unit_price: 10000)
      item2 = create(:item, name: "Item2", unit_price: 20012)
      item3 = create(:item, name: "Item3", unit_price: 2500)
      merchant.items << [item1, item2, item3]
      invoice1 = create(:invoice, status: 'shipped', merchant: merchant)
      invoice2 = create(:invoice, status: 'shipped', merchant: merchant)
      invoice3 = create(:invoice, status: 'shipped', merchant: merchant)
      item1.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 3, unit_price: item1.unit_price)
      item1.invoice_items << create(:invoice_item, invoice: invoice2, quantity: 2, unit_price: item1.unit_price)
      item2.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 1, unit_price: item2.unit_price)
      item3.invoice_items << create(:invoice_item, invoice: invoice3, quantity: 2, unit_price: item3.unit_price)
      transaction1 = create(:transaction, invoice: invoice1, result: 'success')
      transaction2 = create(:transaction, invoice: invoice2, result: 'success')
      transaction3 = create(:transaction, invoice: invoice3, result: 'success')

      get "/api/v1/items/most_items?quantity=2"

      top_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(top_items[0]['name']).to eq("Item1")
      expect(top_items[0]['id']).to eq(item1.id)
      expect(top_items[1]['name']).to eq("Item3")
      expect(top_items[1]['id']).to eq(item3.id)
    end
  end
end
