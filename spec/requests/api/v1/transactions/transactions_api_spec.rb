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

  it "returns a single transaction" do
    transaction1, transaction2 = create_list(:transaction, 2)

    get "/api/v1/transactions/#{transaction1.id}.json"

    parsed_transaction1 = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed_transaction1).to have_key(:result)
    expect(parsed_transaction1).to have_key(:invoice_id)
    expect(parsed_transaction1[:id]).to eq(transaction1.id)
    expect(parsed_transaction1[:id]).to_not eq(transaction2.id)
  end
end
