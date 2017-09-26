require "rails_helper"

RSpec.describe RecipesController, type: :controller do
  let(:valid_attributes) { FactoryGirl.create(:recipe).attributes }

  let(:invalid_attributes) do
    {
      "name" => "",
      "description" => ""
    }
  end

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      recipe = FactoryGirl.create(:recipe)
      get :show, params: { id: recipe.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      user = FactoryGirl.create(:user)
      sign_in user
      recipe = FactoryGirl.build(:recipe)
      get :new, params: { id: recipe.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      user = FactoryGirl.create(:user)
      recipe = FactoryGirl.create(:recipe, user: user)
      sign_in user
      get :edit, params: { id: recipe.id }, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Recipe" do
        expect do
          user = FactoryGirl.create(:user)
          sign_in user
          post :create, params: { recipe: valid_attributes }, session: valid_session
        end.to change { Recipe.count }.by(1)
      end

      it "redirects to the created recipe" do
        user = FactoryGirl.create(:user)
        sign_in user
        post :create, params: { recipe: valid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end

    context "with invalid params" do
      it "returns a success response (to display the 'new' template)" do
        user = FactoryGirl.create(:user)
        sign_in user
        post :create, params: { recipe: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          "name" => "New name",
          "description" => "New description"
        }
      end

      it "updates the requested recipe" do
        user = FactoryGirl.create(:user)
        sign_in user
        recipe = FactoryGirl.create(:recipe, user: user)
        new_recipe_attributes = recipe.attributes.merge(new_attributes)
        put :update, params: { id: recipe.to_param, recipe: new_recipe_attributes }, session: valid_session
        recipe.reload
        expect(recipe.name).to eq "New name"
        expect(recipe.description).to eq "New description"
      end

      it "redirects to the recipe" do
        user = FactoryGirl.create(:user)
        sign_in user
        recipe = FactoryGirl.create(:recipe, user: user)
        put :update, params: { id: recipe.to_param, recipe: valid_attributes }, session: valid_session
        expect(response).to redirect_to(recipe)
      end
    end

    context "with invalid params" do
      it "returns a success response (to display the 'edit' template)" do
        user = FactoryGirl.create(:user)
        sign_in user
        recipe = FactoryGirl.create(:recipe, user: user)
        put :update, params: { id: recipe.to_param, recipe: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recipe" do
      user = FactoryGirl.create(:user)
      recipe_to_delete = FactoryGirl.create(:recipe, user: user)
      sign_in user
      expect do
        delete :destroy, params: { id: recipe_to_delete.to_param }, session: valid_session
      end.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
      user = FactoryGirl.create(:user)
      recipe_to_delete = FactoryGirl.create(:recipe, user: user)
      sign_in user
      delete :destroy, params: { id: recipe_to_delete.to_param }, session: valid_session
      expect(response).to redirect_to(recipes_url)
    end
  end
end
