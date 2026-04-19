require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a pin' do
      user.pin = nil
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Pin can't be blank")
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: user.email)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include('Email has already been taken')
    end
  end

  describe 'associations' do
    context 'has one account' do
      it { should have_one(:account) }
    end

    context 'dependent destroy' do
      it 'destroys associated account when user is destroyed' do
        user.save
        account = create(:account, user: user)
        expect { user.destroy }.to change { Account.count }.by(-1)
      end
    end
  end
end
