require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "#index" do
    subject do
      get :index
      response
    end

    it { is_expected.to have_http_status :ok }
    it { is_expected.to match_response_schema 'users' }
  end

  describe "#show" do
    subject do
      get :show, params
      response
    end

    context "when a user is not found" do
      let(:params) {{ id: -1 }}

      it { is_expected.to have_http_status :not_found }
    end

    context "when a user is found" do
      let(:user) { create(:user) }
      let(:params) {{ id: user.id }}

      it { is_expected.to have_http_status :ok }
      it { is_expected.to match_response_schema 'user' }
    end
  end

  describe "#create" do
    subject do
      post :create, { user: user_params }
      response
    end

    context "when a valid name is not included" do
      let(:user_params) {{ password: "password", password_confirmation: "password" }}

      it { is_expected.to have_http_status :unprocessable_entity }
    end

    context "when a valid password is not included" do
      let(:user_params) {{ name: "user", password_confirmation: "password" }}

      it { is_expected.to have_http_status :unprocessable_entity }
    end

    context "when a valid password_confirmation is not included" do
      let(:user_params) {{ name: "user", password: "password", password_confirmation: "password2" }}

      it { is_expected.to have_http_status :unprocessable_entity }
    end

    context "when valid parameters are included" do
      let(:user_params) {{ name: "User", password: "password", password_confirmation: "password"}}

      it { is_expected.to have_http_status :created }
      it { is_expected.to match_response_schema 'user' }
    end
  end

end
