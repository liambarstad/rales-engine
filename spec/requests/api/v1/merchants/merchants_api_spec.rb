require 'rails_helper'

describe "Merchants API" do
  it "sends a collection of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
  end
end
