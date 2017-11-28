require 'rails_helper'

RSpec.describe "invoices basic endpoints" do
  context "with correct information" do
    it "can return all invoices" do
      invoices = create_list(:invoice, 3)

      get "/api/v1/invoices.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(3)
      expect(result[0]["id"]).to eq(invoices[0].id)
    end

    it "can return a single invoice" do
      invoice1, invoice2 = create_list(:invoice, 2)

      get "/api/v1/invoices/#{invoice1.id}.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice1.id)
    end

    it "can return an invoice by status" do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice, status: "resting")

      get "/api/v1/invoices/find?status=resting"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice2.id)
    end

    it "can return all invoices by status" do
      invoice1, invoice2 = create_list(:invoice, 2, status: 'resting')
      invoice3 = create(:invoice)

      get "/api/v1/invoices/find_all?status=resting"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result[0]["id"]).to eq(invoice1.id)
      expect(result[1]["id"]).to eq(invoice2.id)
    end

    it "can pick a random invoice" do
      invoice1, invoice2, invoice3 = create_list(:invoice, 3)

      get "/api/v1/invoices/random.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
