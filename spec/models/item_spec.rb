require 'rails_helper'
require 'date'

RSpec.describe Item, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices) }

  describe '#best_day' do
    xit 'returns the date associated with the most invoices for an item' do
      #set up item, 2 invoices, 2 transaction, invoice_items

      date = invoice1.created_at
      expect(item.best_day).to eq date
    end

    xit 'returns most recent date if two dates have max amount of items created' do

    end
  end
end
