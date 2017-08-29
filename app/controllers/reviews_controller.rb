class ReviewsController < ApplicationController
  before_action :set_recipe
  before_action :set_review, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[new edit]

  def new
    @review = Review.new
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @review = Review.new(review_params)
    @review.recipe_id = @recipe.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    if @review.update(review_params)
      redirect_to recipe_path(@recipe)
    else
      render "edit"
    end
  end

  def destroy
    @review.destroy
    redirect_to recipe_path(@recipe)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
