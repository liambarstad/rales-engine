require 'rails_helper'

describe "Customers API" do
  describe "GET /api/v1/customers/:id/favorite_merchant" do
    it 'calls favorite_merchant on customer and returns the favorite merchant' do

      customer = double()
      merchant = create :merchant

      allow(Customer).to receive(:find).with('1') { customer }
      expect(customer).to receive(:favorite_merchant).once { merchant }

      get '/api/v1/customers/1/favorite_merchant'

      parsed_favorite_merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(parsed_favorite_merchant['id']).to eq merchant.id
      expect(parsed_favorite_merchant['name']).to eq merchant.name
    end
  end
end
