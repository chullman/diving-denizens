class DeliveryFee < ApplicationRecord
    has_many :cart_items
end
