require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { user_id: 1 } }

  describe '.encode' do
    it 'return a token string' do
      token = described_class.encode(payload)

      expect(token).to be_a(String)
    end
  end

  describe '.decode' do
    it 'returns decoded payload' do
      token = described_class.encode(payload)
      decoded_payload = described_class.decode(token)

      expect(decoded_payload[:user_id]).to eq(1)
    end

    it 'returns nil for invalid token' do
      expect(described_class.decode('invalid token')).to be_nil
    end

    it 'returns nil for expired token' do
      token = described_class.encode(payload, 1.second.ago)
      expect(described_class.decode(token)).to be_nil
    end

    it 'returns hash with indifferent access' do
      token = described_class.encode(payload)
      decoded = described_class.decode(token)

      expect(decoded['user_id']).to eq(1)
      expect(decoded[:user_id]).to eq(1)
    end
  end
end
