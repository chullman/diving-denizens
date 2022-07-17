json.extract! cart_item, :id, :user_id, :listing_id, :cart_num, :delivery_fee_id, :created_at, :updated_at
json.url cart_item_url(cart_item, format: :json)
