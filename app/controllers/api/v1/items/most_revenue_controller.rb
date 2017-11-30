class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    render json: Item.by_revenue(params["quantity"])
  end

end
