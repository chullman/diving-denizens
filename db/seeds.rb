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

Category.create!([{ name: "wetsuit" }, { name: "bcd" }, { name: "mask" }, { name: "snorkel" }, { name: "fins" }, { name: "regulators" }, { name: "computer" }, { name: "spg" }])

ListingFee.create!(fee_price: 0.30, valid_from: Time.now.to_datetime)