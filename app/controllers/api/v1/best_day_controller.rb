class Api::V1::BestDayController < ApplicationController

  def show
    render json: { "best_day" => "#{item.best_day}"}
  end

  private

  def item
    Item.find(params[:item_id])
  end

end
