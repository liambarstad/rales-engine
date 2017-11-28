FactoryBot.define do
  factory :transaction do
    sequence :invoice_id { |n| "1#{n}".to_i }
    credit_card_number 4187236528793125
    result "Success"
  end
end
