require 'rails_helper'

RSpec.feature "can get favorite customer for merchant" do
  it "with valid parameters" do
    merchant = create(:merchant)
    customer1, customer2, customer3 = create_list(:customer, 3)
    invoice1, invoice2 = create_list(:invoice, 2, merchant: merchant, customer: customer1)
    invoice3 = create(:invoice, merchant: merchant, customer: customer2)
    transaction1, transaction2 = create_list(:transaction, 2, invoice: invoice3, result: 'success')
    transaction3 = create(:transaction, invoice: invoice1, result: 'failed')
    transaction4 = create(:transaction, invoice: invoice2, result: 'success')

    favorite_customer = merchant.favorite_customer

    expect(favorite_customer.id).to eq(customer2.id)
  end
end
