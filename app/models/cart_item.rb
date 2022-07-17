class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  belongs_to :delivery_fee
end
