class Api::V1::InvoiceItems::FindController < ApplicationController

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

end
