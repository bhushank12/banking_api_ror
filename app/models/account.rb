class Account < ApplicationRecord
  belongs_to :user

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :account_number, uniqueness: true
  validates :ifsc_code, presence: true
  validates :branch_name, presence: true

  before_create :generate_account_number

  private

  def generate_account_number
    self.account_number ||= loop do
      num = "ACC#{SecureRandom.random_number(10**10)}"
      break num unless Account.exists?(account_number: num)
    end
  end
end
