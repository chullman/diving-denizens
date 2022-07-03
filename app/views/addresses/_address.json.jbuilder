json.extract! address, :id, :first_name, :last_name, :unit_type, :unit_num, :lvl_type, :lvl_num, :street_type, :street_num, :street_name, :suburb, :postcode_id, :created_at, :updated_at
json.url address_url(address, format: :json)
