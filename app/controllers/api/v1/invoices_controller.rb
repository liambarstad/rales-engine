class Api::V1::InvoicesController < ApplicationController

  def show
    render json: Invoice.find(params["id"])
  end

  def index
    render json: Invoice.all
  end

end
