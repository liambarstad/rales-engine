class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    render json: invoice_item.invoice
  end

  private

  def invoice_item
    InvoiceItem.find(params[:id])
  end
end
