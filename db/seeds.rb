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
  alice = User.find_or_create_by!(email: "alice@example.com") do |u|
    u.name = "Alice"
    u.pin = "1234"
  end
  account = Account.find_or_create_by!(user: alice,
    balance: 1000,
    ifsc_code: "HDFC0001234",
    branch_name: "Pune",
    address: "Pune Main Branch"
  )
  account.transactions.find_or_create_by!(amount: 1000, transaction_type: :credit)
end

# Bob as a user
ActiveRecord::Base.transaction do
  bob = User.find_or_create_by!(email: "bob@example.com") do |u|
    u.name = "Bob"
    u.pin = "4321"
  end
  account = Account.find_or_create_by!(
    user: bob,
    balance: 500,
    ifsc_code: "HDFC0001234",
    branch_name: "Pune",
    address: "Pune Branch"
  )
  account.transactions.find_or_create_by!(amount: 500, transaction_type: :credit)
end
