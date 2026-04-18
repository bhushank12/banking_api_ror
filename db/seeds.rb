# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Alice as a user
ActiveRecord::Base.transaction do
  alice = User.create!(name: "Alice", email: "alice@example.com", pin: "1234")
  Account.create!(user: alice,
    balance: 1000,
    ifsc_code: "HDFC0001234",
    branch_name: "Pune",
    address: "Pune Main Branch"
  )
end

# Bob as a user
ActiveRecord::Base.transaction do
  bob = User.create!(name: "Bob", email: "bob@example.com", pin: "4321")
  Account.create!(
    user: bob,
    balance: 500,
    ifsc_code: "HDFC0001234",
    branch_name: "Pune",
    address: "Pune Branch"
  )
end
