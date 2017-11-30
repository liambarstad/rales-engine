require 'rails_helper'

RSpec.describe "api can return customer associations" do
  it "can return invoices" do
    customer = create(:customer)
    invoice1, invoice2 = create_list(:invoice, 2, customer: customer)
    invoice3 = create(:invoice)
    
    get "/api/v1/customers/#{customer.id}/invoices"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
    expect(result[0]["id"]).to eq(invoice1.id)
    expect(result[1]["id"]).to eq(invoice2.id)
  end

  it "can return transactions" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    transaction1, transaction2 = create_list(:transaction, 2, invoice: invoice)
    transaction3 = create(:transaction)

    get "/api/v1/customers/#{customer.id}/transactions"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.count).to eq(2)
    expect(result[0]["id"]).to eq(transaction1.id)
    expect(result[1]["id"]).to eq(transaction2.id)
  end

end
