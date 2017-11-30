require 'rails_helper'

describe "Merchants API" do
  describe "get /api/v1/merchants/:id/revenue" do
    it "calls revenue on the merchant specified in the params and returns revenue as json" do

      merchant = double()
      allow(Merchant).to receive(:find).with("1") { merchant }
      expect(merchant).to receive(:revenue).once { 700.12 }

      get "/api/v1/merchants/1/revenue"

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(revenue).to have_key(:revenue)
      expect(revenue[:revenue]).to eq("700.12")
    end
  end
end
