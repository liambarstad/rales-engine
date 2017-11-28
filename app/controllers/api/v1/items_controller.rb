class Api::V1::ItemsController < ApplicationController

  def show
    render json: Item.find(params["id"])
  end

  def index
    render json: Item.all
  end

end
