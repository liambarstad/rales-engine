require 'rails_helper'

describe "Merchants API" do
  it "sends a collection of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants.json"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(merchants.count).to eq(3)
  end

  it "returns a single merchant" do
    merchant1, merchant2 = create_list(:merchant, 2)

    get "/api/v1/merchants/#{merchant1.id}.json"

    parsed_merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_success
    expect(parsed_merchant).to have_key(:name)
    expect(parsed_merchant[:id]).to eq(merchant1.id)
    expect(parsed_merchant[:name]).to_not eq(merchant2.name)
  end

  describe "finds merchants by parameters" do
    context "that are case insensitive"
    it "finds a merchant by name in all caps" do
      merchant1, merchant2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find?name=#{merchant1.name.upcase}"

      parsed_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_merchant).to have_key(:name)
      expect(parsed_merchant[:id]).to eq(merchant1.id)
      expect(parsed_merchant[:name]).to eq(merchant1.name)
      expect(parsed_merchant[:name]).to_not eq(merchant2.name)
    end
    
    xit "finds a merchant by name with all lowercase" do
      merchant1, merchant2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find?name=#{merchant1.name.swapcase}"

    end

    xit "finds merchant by id" do

    end

    xit "finds merchant by created_at" do

    end

    xit "finds merchant by updated_at" do

    end
  end
end
