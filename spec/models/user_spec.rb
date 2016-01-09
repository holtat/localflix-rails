require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:user, name: nil)).not_to be_valid
  end

  it "is invalid without a name" do
    expect(build(:user, password: nil)).not_to be_valid
  end

  it "is invalid without a password_confirmation" do
    expect(build(:user, password_confirmation: nil)).not_to be_valid
  end

end
