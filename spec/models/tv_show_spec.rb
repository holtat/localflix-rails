require 'rails_helper'

RSpec.describe TvShow, type: :model do

  it "has a valid factory" do
    expect(build(:tv_show)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:tv_show, name: nil)).to be_invalid
  end

  it "is invalid without a user" do
    expect(build(:tv_show, user: nil)).to be_invalid
  end
end
