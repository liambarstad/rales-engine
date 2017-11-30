class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :name, :merchant_id, :unit_price

  def unit_price
    object.unit_price.to_s
  end
end
