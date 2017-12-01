class Api::V1::Merchants::PendingInvoicesController < ApplicationController

  def index
    merchant = Merchant.find(params["id"])
    customers = merchant.customers_with_pending_invoices
    render json: customers.to_json
  end

end
