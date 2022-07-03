class Postcode < ApplicationRecord
    self.primary_key = :postcode
    has_many :addresses
end
