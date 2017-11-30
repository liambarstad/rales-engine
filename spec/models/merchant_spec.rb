require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:invoices) }
  it { should have_many(:items) }

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
