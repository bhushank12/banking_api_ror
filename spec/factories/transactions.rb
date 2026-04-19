FactoryBot.define do
  factory :transaction do
    association :account
    amount { "100.20" }
    transaction_type { "credit" }
  end
end
