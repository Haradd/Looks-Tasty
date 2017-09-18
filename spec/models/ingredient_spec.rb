require "rails_helper"

RSpec.describe Ingredient, type: :model do
  it "has a valid factory" do
    expect(build(:ingredient)).to be_valid
  end
  describe "associations" do
    it { should belong_to :recipe }
  end
end
