require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:account) { create(:account) }
  let(:transaction) { build(:transaction, account: account) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(transaction).to be_valid
    end

    it 'is not valid without an amount' do
      transaction.amount = nil
      expect(transaction).not_to be_valid
      expect(transaction.errors.full_messages).to include("Amount can't be blank")
    end

    it 'is not valid with a non-positive amount' do
      transaction.amount = -10
      expect(transaction).not_to be_valid
      expect(transaction.errors.full_messages).to include("Amount must be greater than 0")
    end

    it 'is not valid without a transaction type' do
      transaction.transaction_type = nil
      expect(transaction).not_to be_valid
      expect(transaction.errors.full_messages).to include("Transaction type can't be blank")
    end

    it 'is not valid with an invalid transaction type' do
      transaction.transaction_type = 'invalid_type'
      expect(transaction).not_to be_valid
      expect(transaction.errors.full_messages).to include("Transaction type is not included in the list")
    end
  end

  describe 'associations' do
    it 'belongs to account' do
      expect(transaction).to belong_to(:account)
    end
  end
end
