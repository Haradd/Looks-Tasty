require "rails_helper"

RSpec.describe Category, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it do
      should validate_inclusion_of(:name).in_array(
        ["Appetizers & Snacks", "Breakfast & Brunch", "Dinner", "Desserts", "Drinks"]
      )
    end
  end

  describe "associations" do
    it { should have_many(:recipes) }
  end
end
