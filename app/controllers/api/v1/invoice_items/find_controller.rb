class Api::V1::InvoiceItems::FindController < ApplicationController

    before_action :format_params

    def show
        render json: InvoiceItem.where(invoice_item_params).first
    end

    def index
        render json: InvoiceItem.where(invoice_item_params)
    end

    private

    def invoice_item_params
        params.permit(:id, :quantity, :unit_price, :created_at, :updated_at)
    end

    def format_params
      params[:unit_price] = params[:unit_price].to_f.round(2) if params[:unit_price]
      params[:quantity] = params[:quantity].to_i if params[:quantity]
    end

end
