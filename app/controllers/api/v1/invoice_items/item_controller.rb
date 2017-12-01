class Api::V1::InvoiceItems::ItemController < ApplicationController


  def show
    render json: invoice_item.item
  end

  private

  def invoice_item
    InvoiceItem.find(params[:id])
  end
end
