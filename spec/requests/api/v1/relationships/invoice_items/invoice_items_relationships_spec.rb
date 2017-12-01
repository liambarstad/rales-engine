require 'rails_helper'

describe 'Invoice_Items API' do
  describe 'renders relationship data for database associations' do
    describe 'get /api/v1/invoice_items/:id/invoice' do
      it 'calls invoice on an invoice_item and renders associated invoice as json' do

        invoice = create :invoice
        invoice_item = create :invoice_item, invoice: invoice

        allow(InvoiceItem).to receive(:find).with('1') { invoice_item }
        expect(invoice_item).to receive(:invoice).once { invoice }

        get '/api/v1/invoice_items/1/invoice'

        parsed_invoice = JSON.parse(response.body)

        expect(response).to be_success
        expect(parsed_invoice['id']).to eq invoice.id
      end
    end

    describe 'get /api/v1/invoice_items/:id/item' do
      it 'calls item on an invoice_item and renders associated item as json' do

        item = create :item
        invoice_item = create :invoice_item, item: item

        allow(InvoiceItem).to receive(:find).with('2') { invoice_item }
        expect(invoice_item).to receive(:item).once { item }

        get '/api/v1/invoice_items/2/item'

        parsed_item = JSON.parse(response.body)

        expect(response).to be_success
        expect(parsed_item['id']).to eq item.id

      end
    end
  end
end
