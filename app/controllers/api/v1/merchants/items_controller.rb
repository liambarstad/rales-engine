class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: merchant.items
  end

  private

  def merchant
    Merchant.find(params[:id])
  end
end
