require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many(:invoices) }

  describe '#favorite_merchant' do
    it 'returns the merchant where the customer has completed the most successful transactions' do
      customer = create :customer
      merchant1 = create :merchant
      merchant2 = create :merchant

      item1 = create :item, merchant: merchant1
      invoice1 = create :invoice, merchant: merchant1, customer: customer
      create :invoice_item, invoice: invoice1, item: item1, quantity: 1
      create :transaction, invoice: invoice1

      item2 = create :item, merchant: merchant2
      invoice2 = create :invoice, merchant: merchant2, customer: customer
      create :invoice_item, invoice: invoice2, item: item2, quantity: 2
      create :transaction, invoice: invoice2


      expect(customer.favorite_merchant).to eq merchant2
    end
  end
end
