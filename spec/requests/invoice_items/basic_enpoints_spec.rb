require 'rails_helper'

RSpec.describe "invoice items basic endpoints" do
  context "with correct information" do
    it "can return all invoice items" do
      invoice_items = create_list(:invoice_item, 3)

      get "/api/v1/invoice_items.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(3)
      expect(result[0]["id"]).to eq(invoice_items[0].id)
    end

    it "can return a single invoice item" do
      invoice_item1, invoice_item2 = create_list(:invoice_item, 2)

      get "/api/v1/invoice_items/#{invoice_item1.id}.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice_item1.id)
    end

    it "can return an invoice item by quantity" do
      invoice_item1 = create(:invoice_item)
      invoice_item2 = create(:invoice_item, quantity: 8)

      get "/api/v1/invoice_items/find?quantity=8"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice_item2.id)
    end

    it "can return all invoice items by quantity" do
      invoice_item1, invoice_item2 = create_list(:invoice_item, 2, quantity: 8)
      invoice_item3 = create(:invoice_item)

      get "/api/v1/invoice_items/find_all?quantity=8"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result[0]["id"]).to eq(invoice1.id)
      expect(result[1]["id"]).to eq(invoice2.id)
    end

    it "can return invoice items by unit price" do
      invoice_item1 = create(:invoice_item)
      invoice_item2 = create(:invoice_item, unit_price: 600)

      get "/api/v1/invoice_items/find?unit_price=6.00"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice_item2.id)
    end

    it "can pick a random invoice item" do
      invoice_item1, invoice_item2, invoice_item3 = create_list(:invoice_item, 3)

      get "/api/v1/invoice_items/random.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
