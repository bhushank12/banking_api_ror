require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user) }

  describe 'POST /login' do
    context 'with valid credentials' do
      it 'returns a JWT token' do
        post '/login', params: { email: user.email, pin: user.pin }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'return an error message for invalid email' do
        post '/login', params: { email: "wrong_email@gmail.com", pin: '1234' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Invalid email or pin' })
      end

      it 'returns an error message for invalid pin' do
        post '/login', params: { email: user.email, pin: 'wrongpin' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Invalid email or pin' })
      end
    end
  end
end
