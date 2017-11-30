require 'rails_helper'

RSpec.describe "invoice relationships, api can return" do
  it "associated transactions" do
    invoice1, invoice2 = create_list(:invoice, 2)
    transaction1, transaction2 = create_list(:transaction, 2, invoice: invoice1)
    transaction3 = create(:transaction, invoice: invoice2)

    get "/api/v1/invoices/#{invoice1.id}/transactions"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.to_a.count).to eq(2)
    expect(result[0]["id"]).to eq(invoice1.id)
    expect(result[1]["id"]).to eq(invoice2.id)
  end
end
