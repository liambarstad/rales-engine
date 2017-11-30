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

  it "associated invoice items" do
    invoice1, invoice2 = create_list(:invoice, 2)
    invoice_item1, invoice_item2 = create_list(:invoice_item, 2, invoice: invoice1)
    invoice_item3 = create(:invoice_item, invoice: invoice2)

    get "/api/v1/invoices/#{invoice1.id}/invoice_items"
    result = JSON.parse(response.body)
    expect(response).to be_success
    expect(result.count).to eq(2)
    expect(result[0]["id"]).to eq(invoice_item1.id)
    expect(result[1]["id"]).to eq(invoice_item2.id)
  end

  it "associated items" do
    invoice1, invoice2 = create_list(:invoice, 2)
    item1, item2, item3 = create_list(:item, 3)
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1)
    invoice_item2 = create(:invoice_item, invoice: invoice1, item: item2)
    invoice_item3 = create(:invoice_item, invoice: invoice2, item: item3)

    get "/api/v1/invoices/#{invoice1.id}/items"
    result = JSON.parse(response.body)
    expect(response).to be_success
    expect(result.count).to eq(2)
    expect(result[0]["id"]).to eq(item1.id)
    expect(result[1]["id"]).to eq(item2.id)
  end

  it "associated customer" do
    customer1, customer2 = create_list(:customer, 2)
    invoice1 = create(:invoice, customer: customer1)
    invoice2 = create(:invoice, customer: customer2)

    get "/api/v1/invoices/#{invoice1.id}/customer"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(customer1.id)
  end

  it "associated merchant" do
    merchant1, merchant2 = create_list(:merchant, 2)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)

    get "/api/v1/invoices/#{invoice1.id}/merchant"
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result["id"]).to eq(merchant1.id)
  end

end
