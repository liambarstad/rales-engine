class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: { revenue: Merchant.total_revenue.to_s }
  end

end
