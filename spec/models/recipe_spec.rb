require "rails_helper"

RSpec.describe Recipe, type: :model do
  it "has a valid factory" do
    expect(create(:recipe)).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :image }
    it { should validate_presence_of :ingredients }
    it { should validate_presence_of :steps }
    it { should validate_length_of(:name).is_at_most(80) }
  end

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :category }

    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:ingredients).dependent(:destroy) }
    it { should have_many(:steps).dependent(:destroy) }
  end
end
