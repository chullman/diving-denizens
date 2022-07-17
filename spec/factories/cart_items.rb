FactoryBot.define do
  factory :cart_item do
    user { nil }
    listing { nil }
    cart_num { "" }
    delivery_fee { nil }
  end
end
