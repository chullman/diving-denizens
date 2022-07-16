FactoryBot.define do
  factory :listing do
    user { nil }
    title { "MyString" }
    description { nil }
    images { nil }
    outright_price { "9.99" }
    negotiable { false }
    quantity { 1 }
    deliverable { false }
    listing_fee { nil }
  end
end
