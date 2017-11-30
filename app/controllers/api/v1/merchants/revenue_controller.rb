class Api::V1::Merchants::RevenueController < ApplicationController

  before_action :format_date

  def index
    render json: { total_revenue: Merchant.total_revenue(params["date"]).to_s }
  end
  
  private

  def format_date
    params["date"] = params["date"].to_datetime
  end

end
