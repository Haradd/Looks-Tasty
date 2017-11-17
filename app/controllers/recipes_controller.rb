class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]
  before_action :correct_user, only: %i[edit update destroy]

  decorates_assigned :recipe

  # GET /recipes
  def index
    pages = 12
    @recipe = Recipe.includes(:reviews)
    @recipe = @recipe.search_with(filter_params[:search])
    @recipe = @recipe.by_category(filter_params[:category])
    @recipe = @recipe.page(params[:page]).per(pages).decorate
  end

  # GET /recipes/1
  def show
    @reviews = Review.includes(:user).joins(:recipe)
                     .where(recipes: { id: @recipe.id }).order("created_at DESC")
                     .page(params[:page]).per(10).decorate
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.build
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes
  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recipe was successfully added."
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Your recipe was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /recipes/1
  def destroy
    if @recipe.destroy
      redirect_to recipes_url, notice: "Your recipe was successfully deleted."
    else
      redirect_to @recipe, notice: "Something went wrong. Recipe was not deleted."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:recipe).permit(:search, :name, :description, :image, :time, :tip,
    :portions, :category_id, page: [:id], ingredients_attributes: %i[id name _destroy],
                             steps_attributes: %i[id step _destroy])
  end

  def filter_params
    params.permit(:search, :category, :sort)
  end

  def correct_user
    @recipe = current_user.recipes.find(params[:id])
    redirect_to recipes_path, notice: "Hey, that is not your recipe!" if @recipe.nil?
  end
end
