require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let(:user) { create(:user) }
  let!(:account) { create(:account, user: user) }

  describe "GET /balance" do
    it "returns the account balance for an authenticated user" do
      token = JsonWebToken.encode(user_id: user.id)
      get "/balance", headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ 'balance' => account.balance.to_f })
    end

    it "returns unauthorized for missing token" do
      get "/balance"

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Missing token' })
    end

    it "returns unauthorized for invalid token" do
      get "/balance", headers: { 'Authorization' => "Bearer invalidtoken" }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Invalid token' })
    end

    it "returns unauthorized for expired token" do
      token = JsonWebToken.encode({ user_id: user.id }, 1.second.ago)
      get "/balance", headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Token has expired' })
    end

    it "returns unauthorized for non-existent user" do
      token = JsonWebToken.encode(user_id: user.id)
      user.destroy
      get "/balance", headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'User not found' })
    end
  end
end
