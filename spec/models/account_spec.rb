require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { build(:account) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(account).to be_valid
    end

    it 'is not valid with negative balance' do
      account.balance = -100
      expect(account).not_to be_valid
      expect(account.errors.full_messages).to include('Balance must be greater than or equal to 0')
    end

    it 'is not valid without an IFSC code' do
      account.ifsc_code = nil
      expect(account).not_to be_valid
      expect(account.errors.full_messages).to include("Ifsc code can't be blank")
    end

    it 'is not valid without a branch name' do
      account.branch_name = nil
      expect(account).not_to be_valid
      expect(account.errors.full_messages).to include("Branch name can't be blank")
    end

    it 'does not allow duplicate account_number' do
      account.save
      duplicate = build(:account, account_number: account.account_number)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors.full_messages).to include('Account number has already been taken')
    end

    it 'generates a unique account number before creation' do
      account.save
      expect(account.account_number).to start_with('ACC')
      expect(Account.where(account_number: account.account_number)).to exist
    end
  end

  describe 'associations' do
    context 'belongs to user' do
      it { should belong_to(:user) }
    end
  end
end
