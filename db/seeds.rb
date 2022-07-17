# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

normal_role = Role.create!(name: 'normal')
admin_role = Role.create!(name: 'admin')

normal_test_user = User.create!(email: 'test@test.com', username: 'normaluser123', password: 'abc123', password_confirmation: 'abc123')
admin_test_user = User.create!(email: 'admin@test.com', username: 'adminuser123', password: 'abc123', password_confirmation: 'abc123')

normal_role = Role.find_by!(name: 'normal')
admin_role = Role.find_by!(name: 'admin')
normal_test_user = User.find_by!(email: 'test@test.com')
admin_test_user = User.find_by!(email: 'admin@test.com')

UserRole.create(role_id: normal_role.id, user_id: normal_test_user.id)
UserRole.create!(role_id: normal_role.id, user_id: admin_test_user.id)
UserRole.create!(role_id: admin_role.id, user_id: admin_test_user.id)

Category.create!([{ name: "Wetsuit" }, { name: "BCD" }, { name: "Mask" }, { name: "Snorkel" }, { name: "Fins" }, { name: "Regulators" }, { name: "Dive Computer" }, { name: "SPG" }])

current_listing_fee = ListingFee.create!(fee_price: 0.30, valid_from: Time.now.to_datetime)

# Create seed Listings with ActionText and ActiveStorage seed data:

# Listing 1:

listing_wetsuit = Listing.create!(
    user_id: normal_test_user.id, 
    title: "Probe 7mm size L wetsuit - GREAT CONDITION", 
    outright_price: 349.99,
    negotiable: false,
    quantity: 1,
    deliverable: true,
    listing_fee_id: current_listing_fee.id)

# Reference: https://linuxtut.com/rails6-input-the-initial-data-of-actiontext-using-seed-9b4f2/ (viewed 17//07/2022) 
# on how to seed a "rich text" Trix field via ActionText
rich_text_content = '<div class="trix-content"><div><strong>I am selling this excellent wetsuit.</strong><br><br>It is certain to keep you warm during cold weather diving!</div></div>'

new_rich_text = ActionText::RichText.create!(record_type: 'Listing', 
                            record_id: listing_wetsuit.id, 
                            name: 'description', 
                            body: '')

new_rich_text.update(body: rich_text_content)

# Reference: https://stackoverflow.com/a/50133403 (viewed 17/07/2022)
# on how to seed ActiveStorage images

listing_wetsuit.images.attach(io: File.open(Rails.root.join("app", "assets", "images", "listing_wetsuit1.jpg")), filename: 'listing_wetsuit1.jpg', content_type: 'image/jpg')
listing_wetsuit.images.attach(io: File.open(Rails.root.join("app", "assets", "images", "listing_wetsuit2.jpg")), filename: 'listing_wetsuit2.jpg', content_type: 'image/jpg')

# Listing 2:

listing_mask = Listing.create!(
    user_id: normal_test_user.id, 
    title: "Black Tusa Freedom dive mask", 
    outright_price: 50.00,
    negotiable: false,
    quantity: 1,
    deliverable: true,
    listing_fee_id: current_listing_fee.id)

rich_text_content = '<div class="trix-content"><div><p>Great for small faces!</p><br><strong>Great condition, and does not fog!</strong></div></div>'

new_rich_text = ActionText::RichText.create!(record_type: 'Listing', 
                            record_id: listing_mask.id, 
                            name: 'description', 
                            body: '')

new_rich_text.update(body: rich_text_content)

listing_mask.images.attach(io: File.open(Rails.root.join("app", "assets", "images", "listing_mask1.jpg")), filename: 'listing_mask1.jpg', content_type: 'image/jpg')
listing_mask.images.attach(io: File.open(Rails.root.join("app", "assets", "images", "listing_mask2.jpg")), filename: 'listing_mask2.jpg', content_type: 'image/jpg')

# Listing 3:

listing_computer = Listing.create!(
    user_id: admin_test_user.id, 
    title: "Oceanic GEO 2 Dive Computer", 
    outright_price: 349.99,
    negotiable: false,
    quantity: 1,
    deliverable: true,
    listing_fee_id: current_listing_fee.id)

rich_text_content = '<div class="trix-content"><div><strong>Small in size and easy to read!</strong></div></div>'

new_rich_text = ActionText::RichText.create!(record_type: 'Listing', 
                            record_id: listing_computer.id, 
                            name: 'description', 
                            body: '')

new_rich_text.update(body: rich_text_content)

listing_computer.images.attach(io: File.open(Rails.root.join("app", "assets", "images", "listing_computer1.jpg")), filename: 'listing_computer1.jpg', content_type: 'image/jpg')
listing_computer.images.attach(io: File.open(Rails.root.join("app", "assets", "images", "listing_computer2.jpg")), filename: 'listing_computer2.jpg', content_type: 'image/jpg')





