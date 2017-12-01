class Api::V1::RevenueController < ApplicationController

  def show
    render json: { revenue: "#{merchant.revenue(params['date'])}" }
  end

  private

  def merchant
    Merchant.find(params[:merchant_id])
  end

end
