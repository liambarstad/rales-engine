require 'date'

FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number "4187236528793125"
    result "Success"
    created_at "2012-03-27T14:54:05.000Z".to_datetime
  end
end
