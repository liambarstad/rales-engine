class Api::V1::Items::MerchantController < ApplicationController

  def show
    render json: item.merchant
  end

  private

  def item
    Item.find(params[:id])
  end
end
