require "rails_helper"

RSpec.describe AdminUser, type: :model do
  it "has a valid factory" do
    expect(build(:admin_user)).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { should allow_values("example@mail.com", "me@me.com").for(:email) }
    it { should_not allow_values("mail", "mail.com").for(:email) }
  end
end
