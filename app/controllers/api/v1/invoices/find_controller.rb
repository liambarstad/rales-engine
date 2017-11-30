class Api::V1::Invoices::FindController < ApplicationController

  def show
    render json: Invoice.where(invoice_params).first
  end

  def index
    render json: Invoice.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:status, :id, :merchant_id, :customer_id, :created_at, :updated_at)
  end

end
