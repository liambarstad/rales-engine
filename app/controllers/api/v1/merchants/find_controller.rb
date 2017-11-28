class Api::V1::Merchants::FindController < ApplicationController

  def show
    require "pry"; binding.pry
    render json: Merchant.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
