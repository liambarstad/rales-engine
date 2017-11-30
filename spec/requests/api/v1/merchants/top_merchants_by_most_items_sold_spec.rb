require 'rails_helper'

describe "Merchants API" do
  describe "get /api/v1/merchants/most_items?quantity=x" do
    it "calls most_items on Merchant with quantity=x from params and returns top x merchants" do
      merchants = create_list(:merchant, 3)
      quantity_params = "3"
      expect(Merchant).to receive(:most_items).with(quantity_params).once { merchants }

      get "/api/v1/merchants/most_items?quantity=3"

      parsed_merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_merchants.count).to eq(3)
    end
  end
end
