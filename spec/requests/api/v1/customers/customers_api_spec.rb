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
end
