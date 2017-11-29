require 'rails_helper'

RSpec.describe "can access favorite customer endpoint" do
  it "with valid parameters" do
    merchant = create(:merchant)
    customer1, customer2, customer3 = create_list(:customer, 3)
    invoice1, invoice2 = create_list(:invoice, 2, merchant: merchant, customer: customer1)
    invoice3 = create(:invoice, merchant: merchant, customer: customer2)
    transaction1, transaction2 = create_list(:transaction, 2, invoice: invoice3, result: 'success')
    transaction3 = create(:transaction, invoice: invoice1, result: 'failed')
    transaction4 = create(:transaction, invoice: invoice2, result: 'success')

    favorite_customer = merchant.favorite_customer
    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(favorite_customer.id)
    expect(result["id"]).to eq(customer2.id)
  end
end

