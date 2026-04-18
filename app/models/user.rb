class User < ApplicationRecord
  has_secure_password :pin

  has_one :account, dependent: :destroy

  validates :name, :pin, presence: true
  validates :email, presence: true, uniqueness: true
end
