json.extract! listing, :id, :user_id, :title, :description, :images, :outright_price, :negotiable, :quantity, :deliverable, :listing_fee_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
json.description listing.description.to_s
json.images do
  json.array!(listing.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
