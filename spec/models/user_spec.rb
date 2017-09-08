require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe "associations" do
    it { should have_many(:reviews) }
    it { should have_many(:recipes) }
    it { should have_many(:user_providers).dependent(:destroy) }
  end
end
