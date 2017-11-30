require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:invoices) }
  it { should have_many(:items) }

  describe '.most_items' do
    it 'returns the merchants who have sold the most items' do
      merchant1, merchant2 = create_list :merchant, 2

      item1 = create :item, merchant: merchant1
      invoice1 = create :invoice, merchant: merchant1
      create :invoice_item, invoice: invoice1, item: item1, quantity: 1
      create :transaction, invoice: invoice1

      item2 = create :item, merchant: merchant2
      invoice2 = create :invoice, merchant: merchant2
      create :invoice_item, invoice: invoice2, item: item2, quantity: 2
      create :transaction, invoice: invoice2

      expect(Merchant.most_items(1)).to eq [merchant2]
      expect(Merchant.most_items(1).first).to eq merchant2
    end
  end

  describe '#revenue' do
    it 'returns the revenue associated with a merchant with only successful transactions' do
      merchant = create :merchant
      item = create :item, merchant: merchant # unit price 1
      invoice = create :invoice, merchant: merchant
      create :invoice_item, invoice: invoice, item: item, quantity: 2
      create :transaction, invoice: invoice

      expect(merchant.revenue).to eq 0.02
    end

    it 'excludes failed transactions from revenue calculation' do
      merchant = create :merchant
      item = create :item, merchant: merchant # unit price 1
      invoice = create :invoice, merchant: merchant
      create :invoice_item, invoice: invoice, item: item, quantity: 2
      create :transaction, invoice: invoice, result: 'failed'

      expect(merchant.revenue).to eq 0
    end
  end
end
