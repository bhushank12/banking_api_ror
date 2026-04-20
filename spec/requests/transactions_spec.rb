require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let!(:account) { create(:account, user: user, balance: 100.0) }

  before do
    allow(controller).to receive(:authorize_request).and_return(true)
    controller.instance_variable_set(:@current_user, user)
  end

  describe 'POST #deposit' do
    context 'when amount is valid' do
      it 'returns success and updated balance' do
        post :deposit, params: { amount: 50 }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(body['balance']).to eq(150.0)
        expect(body['message']).to eq("Deposit successfully")
      end

      it 'actually updates the balance in DB' do
        expect {
          post :deposit, params: { amount: 50 }
        }.to change { account.reload.balance }.from(100.0).to(150.0)
      end
    end

    context 'when amount is zero' do
      it 'returns error' do
        post :deposit, params: { amount: 0 }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(body['error']).to eq("Amount must be greater than 0 or invalid amount")
      end
    end

    context 'when amount is negative' do
      it 'returns error' do
        post :deposit, params: { amount: -10 }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(body['error']).to eq("Amount must be greater than 0 or invalid amount")
      end
    end

    context 'when deposit raises DB error' do
      it 'handles ActiveRecord error' do
        allow_any_instance_of(Account)
          .to receive(:deposit!)
          .and_raise(ActiveRecord::RecordInvalid.new(account))

        post :deposit, params: { amount: 50 }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context 'when amount is invalid (string)' do
      it 'returns error' do
        post :deposit, params: { amount: "abc" }
        body = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_content)
        expect(body['error']).to eq("Amount must be greater than 0 or invalid amount")
      end
    end
  end
end
