require 'rails_helper'

describe "Customers API" do
  it "returns a collection of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers.json"

    customers = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(customers.count).to eq(3)
  end

  it "returns a single customer" do
    customer1, customer2 = create_list(:customer, 2)

    get "/api/v1/customers/#{customer1.id}.json"

    parsed_customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(parsed_customer).to have_key(:id)
    expect(parsed_customer[:first_name]).to eq(customer1.first_name)
    expect(parsed_customer[:last_name]).to_not eq(customer2.last_name)
  end

  describe "finds a single customer by parameters" do
    context "that are case insensitive"
    it "finds a customer by first_name in all caps" do
      customer1, customer2 = create_list(:customer, 2)

      get "/api/v1/customers/find?name=#{customer1.first_name.upcase}"

      parsed_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_customer).to have_key(:first_name)
      expect(parsed_customer[:id]).to eq(customer1.id)
      expect(parsed_customer[:first_name]).to eq(customer1.first_name)
      expect(parsed_customer[:first_name]).to_not eq(customer2.first_name)
    end

    it "finds a customer by last_name with all lowercase" do
      customer1, customer2 = create_list(:customer, 2)

      get "/api/v1/customers/find?last_name=#{customer2.last_name.swapcase}"

      parsed_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_customer).to have_key(:last_name)
      expect(parsed_customer[:id]).to eq(customer2.id)
      expect(parsed_customer[:last_name]).to eq(customer2.last_name)
      expect(parsed_customer[:last_name]).to_not eq(customer1.last_name)
    end

    it "finds customer by id" do
      customer1, customer2 = create_list(:customer, 2)

      get "/api/v1/customers/find?id=#{customer1.id}"

      parsed_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_customer).to have_key(:last_name)
      expect(parsed_customer[:id]).to eq(customer1.id)
      expect(parsed_customer[:last_name]).to eq(customer1.last_name)
      expect(parsed_customer[:last_name]).to_not eq(customer2.last_name)
    end
  end

  describe "it finds a collection of customers with search parameters" do
    it "finds all customers by id" do
      customer1, customer2, customer3 = create_list(:customer, 3)

      get "/api/v1/customers/find_all?id=#{customer3.id}"

      parsed_customers = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_customers.class).to eq(Array)
      expect(parsed_customers[0][:first_name]).to eq(customer3.first_name)
    end

    it "finds all customers by last_name" do
      customer1, customer2, customer3 = create_list(:customer, 3)

      get "/api/v1/customers/find_all?last_name=#{customer2.last_name}"

      parsed_customers = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(parsed_customers.class).to eq(Array)
      expect(parsed_customers[0][:last_name]).to eq(customer2.last_name)
    end
  end

  describe "/api/v1/customers/random" do
    it "returns a random customer" do
      customers = create_list(:customer, 3)
      customer_names = customers.map {|customer| customer.last_name}

      get "/api/v1/customers/random"

      random_customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(customer_names).to include(random_customer[:last_name])
    end
  end
end
