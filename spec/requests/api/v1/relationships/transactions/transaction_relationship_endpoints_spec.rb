require 'rails_helper'

RSpec.describe "api can return transaction associations" do
  it "for an invoice" do
    invoice1, invoice2 = create_list(:invoice, 2)
    transaction = create(:transaction, invoice: invoice1)

    get "/api/v1/transactions/#{transaction.id}/invoice"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(invoice1.id)
  end

end
