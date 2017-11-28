FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number "4187236528793125"
    result "Success"
  end
end
