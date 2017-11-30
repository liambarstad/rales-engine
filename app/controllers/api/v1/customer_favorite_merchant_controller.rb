class Api::V1::CustomerFavoriteMerchantController < ApplicationController

  def show
    render json: customer.favorite_merchant
  end

  private

  def customer
    Customer.find(params[:customer_id])
  end
end
