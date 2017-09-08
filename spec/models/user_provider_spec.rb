require "rails_helper"

RSpec.describe UserProvider, type: :model do
  describe "associations" do
    it { should belong_to :user }
  end
end
