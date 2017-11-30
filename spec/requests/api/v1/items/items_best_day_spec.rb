require 'rails_helper'
require 'date'

describe "Items API" do
  describe "get /api/v1/items/:id/best_day" do
    it "calls best_day on the item specified in params and returns the date as json" do
      item = double()
      date = DateTime.now
      allow(Item).to receive(:find).with("1") { item }
      expect(item).to receive(:best_day).once { date }

      get "/api/v1/items/1/best_day"

      best_day = JSON.parse(response.body)

      expect(response).to be_success
      expect(best_day).to have_key('best_day')
    end
  end
end
