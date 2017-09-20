require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe RecipesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Recipe. As you add validations to Recipe, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.create(:recipe).attributes }

  let(:invalid_attributes) do
    {
      "name" => "",
      "description" => ""
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RecipesController. Be sure to keep this updated too.
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
        recipe = FactoryGirl.create(:recipe)
        new_attributes = recipe.update_attributes(name: "New name", description: "New description")
        put :update, params: { id: recipe.to_param, recipe: new_attributes }, session: valid_session
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
