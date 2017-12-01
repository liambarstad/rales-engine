require 'rails_helper'

describe 'Merchants API' do
  describe 'renders relationship data for database associations' do
    describe 'get /api/v1/merchants/:id/items' do
      it 'calls items on a merchant and renders associated invoices as json' do

        merchant = create :merchant
        items = create_list :item, 2, merchant: merchant

        allow(Merchant).to receive(:find).with('1') { merchant }
        expect(merchant).to receive(:items).once { items }

        get '/api/v1/merchants/1/items'

        merchant_items = JSON.parse(response.body)

        expect(response).to be_success
        expect(merchant_items.count).to eq 2
      end
    end

    describe 'get /api/v1/merchants/:id/invoices' do
      it 'calls invoices on a merchant and renders associated invoices as json' do
        merchant = create :merchant
        invoices = create_list :invoice, 3, merchant: merchant

        allow(Merchant).to receive(:find).with('2') { merchant }
        expect(merchant).to receive(:invoices).once { invoices }

        get '/api/v1/merchants/2/invoices'

        merchant_invoices = JSON.parse(response.body)

        expect(response).to be_success
        expect(merchant_invoices.count).to eq 3

      end
    end
  end
end
