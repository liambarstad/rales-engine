require 'rails_helper'
require 'date'

# assert_equal "2012-03-22T03:55:09.000Z", best_day_one["best_day"]
# assert_equal "2012-03-20T23:57:05.000Z", best_day_two["best_day"]

describe "Items API" do
  describe "get /api/v1/items/:id/best_day" do
    it "returns the date with the most sold item according to invoice date" do
      merchant = create(:merchant)
      item1 = create(:item, name: "Item1", unit_price: 10000)
      merchant.items << item1
      invoice1 = create(:invoice, status: 'shipped', merchant: merchant, created_at: DateTime.now)
      invoice2 = create(:invoice, status: 'shipped', merchant: merchant, created_at: DateTime.now)
      invoice3 = create(:invoice, status: 'shipped', merchant: merchant, created_at: (DateTime.now - 1))
      item1.invoice_items << create(:invoice_item, invoice: invoice1, quantity: 4, unit_price: item1.unit_price)
      item1.invoice_items << create(:invoice_item, invoice: invoice2, quantity: 5, unit_price: item1.unit_price)
      item1.invoice_items << create(:invoice_item, invoice: invoice2, quantity: 5, unit_price: item1.unit_price)
      item1.invoice_items << create(:invoice_item, invoice: invoice3, quantity: 2, unit_price: item1.unit_price)
      transaction1 = create(:transaction, invoice: invoice1, result: 'success')
      transaction2 = create(:transaction, invoice: invoice2, result: 'success')
      transaction3 = create(:transaction, invoice: invoice3, result: 'failed')

      get "/api/v1/items/#{item1.id}/best_day"

      best_day = JSON.parse(response.body)

      expect(response).to be_success
      expect(best_day['best_day']).to eq("#{Datetime.now}")
    end

    xcontext "If there are multiple days with equal number of sales" do
      it "returns the most recent day" do

      end
    end
  end
end
