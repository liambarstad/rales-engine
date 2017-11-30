require 'rails_helper'
require 'date'

RSpec.describe Item, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices) }

  describe '#best_day' do
    it 'returns the date associated with the most invoices for an item' do
      date = DateTime.now

      merchant = create :merchant
      item = create :item, merchant: merchant
      invoice1 = create :invoice, merchant: merchant, created_at: date
      invoice2 = create :invoice, merchant: merchant, created_at: DateTime.now - 1
      create :invoice_item, invoice: invoice1, item: item, quantity: 2
      create :invoice_item, invoice: invoice2, item: item, quantity: 1
      create :transaction, invoice: invoice1
      create :transaction, invoice: invoice2

      expect(item.best_day).to eq invoice1.created_at
    end

    it 'returns most recent date if two dates have max amount of items created' do
      date = DateTime.now

      merchant = create :merchant
      item = create :item, merchant: merchant
      invoice1 = create :invoice, merchant: merchant, created_at: date
      invoice2 = create :invoice, merchant: merchant, created_at: DateTime.now - 1
      create :invoice_item, invoice: invoice1, item: item, quantity: 2
      create :invoice_item, invoice: invoice2, item: item, quantity: 2
      create :transaction, invoice: invoice1
      create :transaction, invoice: invoice2

      expect(item.best_day).to eq invoice1.created_at
    end
  end
end
