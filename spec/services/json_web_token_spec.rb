require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { user_id: 1 } }

  describe '.encode' do
    it 'return a token string' do
      token = described_class.encode(payload)

      expect(token).to be_a(String)
    end
  end
end
