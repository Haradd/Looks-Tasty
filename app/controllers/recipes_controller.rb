class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    pages = 12
    if params[:search].present?
      @recipe = Recipe.where('name LIKE ?', "%#{params[:search]}%").order('created_at DESC').page(params[:page]).per(pages)
    elsif params[:category].blank?
      @recipe = Recipe.all.order('created_at DESC').page(params[:page]).per(pages)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @recipe = Recipe.where(category_id: @category_id).order('created_at DESC').page(params[:page]).per(pages)
    end

  end


  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.build

  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully added.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Your recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Your recipe was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:search, :name, :description, :image, :time, :tip,
      :portions, :category_id,  page:[:id], ingredients_attributes: [:id, :name, :_destroy],
      steps_attributes: [:id, :step, :_destroy])
    end

    def correct_user
      @recipe = current_user.recipes.find_by(id: params[:id])
      redirect_to recipes_path, notice: 'Hey, that is not your recipe!' if @recipe.nil?
    end
end
