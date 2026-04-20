class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :account_number, uniqueness: true
  validates :ifsc_code, presence: true
  validates :branch_name, presence: true

  before_create :generate_account_number

  def deposit!(amount)
    amount = amount.to_f
    raise ArgumentError, "Amount must be greater than 0 or invalid amount" if amount <= 0

    with_lock do
      update!(balance: balance + amount)
      transactions.create!(amount: amount, transaction_type: :credit)
    end
  end

  private

  def generate_account_number
    self.account_number ||= loop do
      num = "ACC#{SecureRandom.random_number(10**10)}"
      break num unless Account.exists?(account_number: num)
    end
  end
end
