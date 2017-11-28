require 'rails_helper'

RSpec.describe "items basic endpoints" do
  context "with correct information" do
    it "can return all items" do
      items = create_list(:item, 3)

      get "/api/v1/items.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(3)
      expect(result[0]["id"]).to eq(items[0].id)
    end

    it "can return a single item" do
      item1, item2 = create_list(:item, 2)

      get "/api/v1/items/#{item1.id}.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(item1.id)
    end

    it "can return an item by name" do
      item1 = create(:item)
      item2 = create(:item, name: "resting")

      get "/api/v1/items/find?name=resting"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(item2.id)
    end

    it "can return all items by name" do
      item1, item2 = create_list(:item, 2, name: 'resting')
      item3 = create(:item)

      get "/api/v1/items/find_all?name=resting"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result[0]["id"]).to eq(item1.id)
      expect(result[1]["id"]).to eq(item2.id)
    end

    it "can pick a random item" do
      item1, item2, item3 = create_list(:item, 3)

      get "/api/v1/item/random.json"
      result = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
