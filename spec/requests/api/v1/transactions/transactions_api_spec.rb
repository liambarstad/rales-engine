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

  describe "finds a single transaction by parameters" do
    context "that are case insensitive"
    it "finds a transaction by result in all caps" do
      transaction1, transaction2 = create_list(:transaction, 2)

      get "/api/v1/transactions/find?result=#{transaction1.result.upcase}"

      parsed_transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_transaction).to have_key(:result)
      expect(parsed_transaction[:id]).to eq(transaction1.id)
      expect(parsed_transaction[:result]).to eq(transaction1.result)
    end

    it "finds transaction by id" do
      transaction1, transaction2 = create_list(:transaction, 2)

      get "/api/v1/transactions/find?id=#{transaction1.id}"

      parsed_transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_transaction).to have_key(:id)
      expect(parsed_transaction[:id]).to eq(transaction1.id)
      expect(parsed_transaction[:result]).to eq(transaction1.result)
    end

    it "finds transaction by credit_card_number" do
      create(:transaction, credit_card_number: "4187236528793125")
      transaction2 = create(:transaction, credit_card_number: "0910934023090923")

      get "/api/v1/transactions/find?credit_card_number=#{transaction2.credit_card_number}"

      parsed_transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_transaction).to have_key(:credit_card_number)
      expect(parsed_transaction[:credit_card_number]).to eq(transaction2.credit_card_number)
    end
  end

  describe "it finds a collection of transactions with search parameters" do
    it "finds all transactions by id" do
      transaction1, transaction2, transaction3 = create_list(:transaction, 3)

      get "/api/v1/transactions/find_all?id=#{transaction3.id}"

      parsed_customers = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_customers.class).to eq(Array)
      expect(parsed_customers[0][:id]).to eq(transaction3.id)
    end

    it "finds all transactions by invoice_id" do
      transaction1, transaction2, transaction3 = create_list(:transaction, 3)

      get "/api/v1/transactions/find_all?invoice_id=#{transaction2.invoice_id}"

      parsed_customers = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_customers.class).to eq(Array)
      expect(parsed_customers[0][:invoice_id]).to eq(transaction2.invoice_id)
    end
  end

  describe "/api/v1/transactions/random" do
    it "returns a random transaction" do
      transactions = create_list(:transaction, 3)
      transaction_ids = transactions.map {|transaction| transaction.id}

      get "/api/v1/transactions/random"

      random_transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(transaction_ids).to include(random_transaction[:id])
    end
  end
end
