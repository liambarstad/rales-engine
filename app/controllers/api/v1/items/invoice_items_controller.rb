class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    render json: item.invoice_items
  end

  private

  def item
    Item.find(params[:id])
  end
end
