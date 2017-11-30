class Api::V1::Items::MostSoldItemsController < ApplicationController

  def index
    render json: Item.most_sold_items(params[:quantity].to_i)
  end
end
