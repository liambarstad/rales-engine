require 'rails_helper'

RSpec.describe "api can return customers with pending invoices" do
  it "for a merchant" do 
    merchant = create(:merchant)
    customer1, customer2, customer3 = create_list(:customer, 3)
    invoice1 = create(:invoice, merchant: merchant, customer: customer1)
    invoice2 = create(:invoice, merchant: merchant, customer: customer2)
    invoice3 = create(:invoice, merchant: merchant, customer: customer3)
    transaction1, transaction2 = create_list(:transaction, 2, invoice: invoice1, result: 'success')
    transaction3 = create(:transaction, invoice: invoice1, result: 'failed')
    transaction4 = create(:transaction, invoice: invoice2, result: 'failed')
    transaction5, transaction6 = create_list(:transaction, 2, invoice: invoice3, result: 'success')

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(1)
    expect(result[0]["id"]).to eq(customer2.id)
  end
end
