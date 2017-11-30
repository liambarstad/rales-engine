FactoryBot.define do
  factory :invoice do
    merchant
    customer
    status "shipped"
  end
end
