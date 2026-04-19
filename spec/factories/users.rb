FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    name { 'Test User' }
    pin { '1234' }
  end
end
