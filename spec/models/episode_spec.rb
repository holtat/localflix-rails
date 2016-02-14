require 'rails_helper'

RSpec.describe Episode, type: :model do

  it 'has a valid spec' do
    expect(build(:episode)).to be_valid
  end

  it 'requires a user' do
    expect(build(:episode, user: nil)).not_to be_valid
  end

  it 'requires a tv_show' do
    expect(build(:episode, tv_show: nil)).not_to be_valid
  end

end
