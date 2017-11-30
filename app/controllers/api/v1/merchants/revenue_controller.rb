class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.total_revenue
  end

end
