require "rails_helper"

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :rating }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5) }
    it { should validate_length_of(:comment).is_at_most(100) }
  end

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :recipe }
  end
end
