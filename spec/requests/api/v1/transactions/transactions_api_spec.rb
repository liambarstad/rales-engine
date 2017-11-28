require 'rails_helper'

describe "Transactions API" do
  it "returns a collection of transactions" do
    create_list(:transaction, 4)

    get "/api/v1/transactions.json"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.status).to eq(200)
    expect(transactions.count).to eq(4)
  end
end
