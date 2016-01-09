require 'rails_helper'

RSpec.describe Services::V1::TokenValidator, type: :service do
  describe '#validate_token' do
    subject { Services::V1::TokenValidator.new.validate_token(token) }

    context 'when an invalid token is given' do
      let(:token) { 'abc' }

      it { is_expected.to eq nil }
    end

    context 'when a valid token is given' do
      let(:payload) { { id: 123 } }
      let(:secret) { Rails.application.secrets[:secret_key_base] }
      let(:token) { JWT.encode(payload, secret) }

      it { is_expected.to eq payload }
    end
  end

  describe '#validate_user' do
    subject { Services::V1::TokenValidator.new.validate_user(token) }

    context 'when an invalid token is given' do
      let(:token) { 'bad_token' }
      before do
        allow_any_instance_of(Services::V1::TokenValidator)
          .to receive(:validate_token).and_return(nil)
      end

      it { is_expected.to eq nil }
    end

    context 'when a valid token is given' do
      let(:user) { create(:user) }
      let(:token) { 'good_token' }
      before do
        allow_any_instance_of(Services::V1::TokenValidator)
          .to receive(:validate_token).and_return(id: user.id)
      end

      it { is_expected.to eq user }
    end
  end
end
