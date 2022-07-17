class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :listing_fee
  has_rich_text :description
  has_many_attached :images

  has_many :listing_categories, dependent: :destroy 
  has_many :categories, through: :listing_categories

  # Uses 'activestorage-validator' gem
  validates :images, presence: false, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(10.megabytes) }

end
