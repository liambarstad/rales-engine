class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    customer = Customer.find(params["id"])
    render json: customer.invoices
  end

end
