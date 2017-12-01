require 'rails_helper'

describe 'Items API' do
  describe 'renders relationship data for database associations' do
    describe 'get /api/v1/items/:id/invoice_items' do
      it 'calls invoice_items on an item and renders associated invoice_items as json' do

        item = create :item
        invoice_items = create_list :invoice_item, 3, item: item

        allow(Item).to receive(:find).with('1') { item }
        expect(item).to receive(:invoice_items).once {invoice_items}

        get '/api/v1/items/1/invoice_items'

        parsed_invoice_items = JSON.parse(response.body)

        expect(response).to be_success
        expect(parsed_invoice_items.count).to eq 3
      end
    end

    describe 'get /api/v1/items/:id/merchant' do
      it 'calls merchant on an item and renders associated merchant as json' do

        merchant = create :merchant
        item = create :item, merchant: merchant

        allow(Item).to receive(:find).with('2') { item }
        expect(item).to receive(:merchant).once { merchant }

        get '/api/v1/items/2/merchant'

        parsed_merchant = JSON.parse(response.body)

        expect(response).to be_success
        expect(parsed_merchant['id']).to eq merchant.id
        expect(parsed_merchant['name']).to eq merchant.name
      end
    end
  end
end
