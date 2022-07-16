class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :listing_fee
  has_rich_text :description
  has_many_attached :images
end
