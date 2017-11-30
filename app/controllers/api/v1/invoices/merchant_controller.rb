class Api::V1::Invoices::MerchantController < ApplicationController

  def show
    invoice = Invoice.find(params["id"])
    render json: invoice.merchant
  end

end
