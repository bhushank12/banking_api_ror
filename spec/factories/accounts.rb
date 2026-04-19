FactoryBot.define do
  factory :account do
    association :user
    balance { 1000.00 }
    ifsc_code { 'HDFC0001' }
    branch_name { 'Main Branch' }
    address { 'Hdfc bank, Pune' }
  end
end
