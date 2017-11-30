class Api::V1::Merchants::MostRevenueController < ApplicationController

  before_action :format_quantity

  def index
    render json: Merchant.by_revenue(params["quantity"])
  end

  private

  def format_quantity
    params["quantity"] = params["quantity"].to_i if params["quantity"]
  end

end
