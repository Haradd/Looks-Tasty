require "rails_helper"

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:username).is_at_most(25) }
    it { should validate_uniqueness_of(:username).ignoring_case_sensitivity }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { should allow_values("name", "user.name", "user_name-2").for(:username) }
    it { should_not allow_values("user!", "!?@#%&*()").for(:username) }

    it { should allow_values("example@mail.com", "me@me.com").for(:email) }
    it { should_not allow_values("mail", "mail.com").for(:email) }
  end

  describe "associations" do
    it { should have_many(:reviews) }
    it { should have_many(:recipes) }
    it { should have_many(:user_providers).dependent(:destroy) }
  end
end
