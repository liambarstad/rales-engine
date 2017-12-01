require 'rails_helper'

RSpec.feature "merchant model can return customers with pending invoices" do
  it "with valid info" do
    merchant = create(:merchant)
    customer1, customer2, customer3 = create_list(:customer, 3)
    invoice1 = create(:invoice, merchant: merchant, customer: customer1)
    invoice2 = create(:invoice, merchant: merchant, customer: customer2)
    invoice3 = create(:invoice, merchant: merchant, customer: customer3)
    transaction1, transaction2 = create_list(:transaction, 2, invoice: invoice1, result: 'success')
    transaction3 = create(:transaction, invoice: invoice1, result: 'failed')
    transaction4 = create(:transaction, invoice: invoice2, result: 'failed')
    transaction5, transaction6 = create_list(:transaction, 2, invoice: invoice3, result: 'success')

    pending_customers = merchant.customers_with_pending_invoices
    pending_customer_ids = pending_customers.pluck(:id)

    expect(pending_customer_ids).to include(customer2.id)
    expect(pending_customer_ids).not_to include(customer3.id)
  end
end
