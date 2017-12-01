class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    render json: merchant.invoices
  end

  private

  def merchant
    Merchant.find(params[:id])
  end
end
