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

    context 'has many transactions' do
      it { should have_many(:transactions) }
    end

    context 'dependent destroy' do
      it 'destroys associated transactions when account is destroyed' do
        account.save
        create(:transaction, account: account)
        expect { account.destroy }.to change { Transaction.count }.by(-1)
      end
    end
  end

  describe '#deposit!' do
    context 'when amount is valid' do
      it 'increases the balance' do
        account.deposit!(50)

        expect(account.reload.balance.to_f).to eq(1050.0)
      end

      it 'creates a transaction record' do
        expect { account.deposit!(50) }.to change { account.transactions.count }.by(1)
        txn = account.transactions.last
        expect(txn.amount).to eq(50.0)
        expect(txn.transaction_type).to eq("credit")
      end
    end

    context 'when amount is zero or negative' do
      it 'raises error for zero' do
        expect { account.deposit!(0) }.to raise_error(ArgumentError, 'Amount must be greater than 0 or invalid amount')
      end

      it 'raises error for negative amount' do
        expect { account.deposit!(-10) }.to raise_error(ArgumentError, 'Amount must be greater than 0 or invalid amount')
      end
    end

    context 'when amount is invalid string' do
      it 'raises error' do
        expect { account.deposit!("abc") }.to raise_error(ArgumentError, 'Amount must be greater than 0 or invalid amount')
      end
    end
  end
end
