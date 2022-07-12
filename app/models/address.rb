class Address < ApplicationRecord

  belongs_to :postcode, foreign_key: :postcode_id
  belongs_to :user, required: false

  #validates :user, presence: false


end
