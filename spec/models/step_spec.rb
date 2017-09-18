require "rails_helper"

RSpec.describe Step, type: :model do
  it "has a valid factory" do
    expect(build(:step)).to be_valid
  end
  describe "associations" do
    it { should belong_to :recipe }
  end
end
