class ReviewsController < ApplicationController
  before_action :set_recipe
  before_action :set_review, only: %i[edit update destroy]
  before_action :check_if_user_is_signed_in, only: %i[new]
  before_action :authenticate_user!, except: %i[index]
  before_action :check_if_user_already_posted_review, only: %i[new create]

  decorates_assigned :review

  def new
    @review = @recipe.reviews.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @review = current_user.reviews.build(review_params)
    @recipe.reviews << @review

    respond_to do |format|
      if @review.save
        format.html { redirect_to recipe_path(@recipe), notice: "Successfully added new review" }
      else
        format.js { render "new" }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to recipe_path(@recipe), notice: "Successfully edited the review" }
      else
        format.js { render "edit" }
      end
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

  def check_if_user_is_signed_in
    return if current_user.present?
    flash[:notice] = "Please sign in before adding a review"
    render js: "window.location.href='" + new_user_session_path + "'"
  end

  def check_if_user_already_posted_review
    return if @recipe.reviews.where(user_id: current_user.id).count.zero?
    flash[:notice] = "You have already posted review. However, it can be edited"
    render js: "window.location.href='" + recipes_path + "/" + @recipe.id.to_s + "'"
  end
end
