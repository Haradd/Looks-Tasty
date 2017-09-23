require "rails_helper"
RSpec.describe ReviewsController, type: :controller do
  let(:valid_attributes) do
    {
      "rating" => "4",
      "comment" => "Tasty!"
    }
  end

  let(:invalid_attributes) do
    {
      "rating" => "",
      "comment" => ""
    }
  end

  let(:valid_session) { {} }

  describe "GET #new" do
    it "returns a success response" do
      recipe = FactoryGirl.create(:recipe)
      review = FactoryGirl.build(:review, recipe: recipe)
      get :new, xhr: true, params: { recipe_id: recipe.id, id: review.to_param }, format: :js
      expect(response).to be_success
    end
  end
end
