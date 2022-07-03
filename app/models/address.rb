class Address < ApplicationRecord
  belongs_to :postcode, foreign_key: :postcode_id
end
