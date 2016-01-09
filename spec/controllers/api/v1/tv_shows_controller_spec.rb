require 'rails_helper'

RSpec.describe API::V1::TvShowsController, type: :controller do
  describe '#index' do
    subject do
      authenticate user if user
      get :index
      response
    end

    context 'when authenticated' do
      let(:user) { create(:user) }
      before { create(:tv_show, user: user) }

      it { is_expected.to have_http_status :ok }
      it { is_expected.to match_response_schema 'tv_shows' }
    end
  end

  describe '#show' do
    subject do
      authenticate user if user
      get :show, params
      response
    end

    context 'when authenticated' do
      let(:user) { create(:user) }

      context 'when the id is valid' do
        context 'when unauthorized' do
          let(:tv_show) { create(:tv_show) }
          let(:params) { { id: tv_show.id } }

          it { is_expected.to have_http_status :unauthorized }
        end

        context 'when authorized' do
          let(:tv_show) { create(:tv_show, user: user) }
          let(:params) { { id: tv_show.id } }

          it { is_expected.to have_http_status :ok }
          it { is_expected.to match_response_schema 'tv_show' }
        end
      end

      context 'when the id not valid' do
        let(:params) { { id: -1 } }

        it { is_expected.to have_http_status :not_found }
      end
    end
  end
end
