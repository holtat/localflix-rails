require 'rails_helper'

describe TvShowPolicy do
  let(:user) { create(:user) }

  subject { TvShowPolicy.new(user, tv_show) }

  context 'when the show does not belong to the user' do
    let(:tv_show) { create(:tv_show) }

    it { is_expected.not_to permit(:show) }
  end

  context 'when the show belongs to the user' do
    let(:tv_show) { create(:tv_show, user: user) }

    it { is_expected.to permit(:show) }
  end
end
