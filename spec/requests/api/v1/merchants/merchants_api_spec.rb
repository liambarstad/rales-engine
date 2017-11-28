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

  describe "finds a single merchant by parameters" do
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

    it "finds a merchant by name with all lowercase" do
      merchant1, merchant2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find?name=#{merchant2.name.swapcase}"

      parsed_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_merchant).to have_key(:name)
      expect(parsed_merchant[:id]).to eq(merchant2.id)
      expect(parsed_merchant[:name]).to eq(merchant2.name)
      expect(parsed_merchant[:name]).to_not eq(merchant1.name)
    end

    it "finds merchant by id" do
      merchant1, merchant2 = create_list(:merchant, 2)

      get "/api/v1/merchants/find?id=#{merchant1.id}"

      parsed_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_merchant).to have_key(:name)
      expect(parsed_merchant[:id]).to eq(merchant1.id)
      expect(parsed_merchant[:name]).to eq(merchant1.name)
      expect(parsed_merchant[:name]).to_not eq(merchant2.name)
    end

    xit "finds merchant by created_at" do

    end

    xit "finds merchant by updated_at" do

    end
  end

  describe "it finds a collection of merchants with search parameters" do
    it "finds all merchants by id" do
      merchant1, merchant2, merchant3 = create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?id=#{merchant3.id}"

      parsed_merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_merchants.class).to eq(Array)
      expect(parsed_merchants[0][:name]).to eq(merchant3.name)
    end

    it "finds all merchants by name" do
      merchant1, merchant2, merchant3 = create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?name=#{merchant2.name}"

      parsed_merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_merchants.class).to eq(Array)
      expect(parsed_merchants[0][:name]).to eq(merchant2.name)
    end

    xit "finds all merchants by created_at date" do
    end

    xit "finds all merchants by updated_at date" do
    end

  end
end
