module Api
  module V1
    class ReviewsController < Api::ApplicationController
      include ReviewsDoc

      before_action :authorize_request, except: [:show]
      before_action :set_review, except: :create

      def show
        render json: @review
      end

      def create
        @review = current_user.reviews.build(review_params)
        Recipe.find(params[:recipe_id]).reviews << @review

        if @review.save
          render json: @review, status: 201
        else
          render json: { errors: @review.errors }, status: 422
        end
      end

      def update
        if @review.update(recipe_params)
          render json: @review, status: 200
        else
          render json: { errors: @review.errors }, status: 422
        end
      end

      def destroy
        @review.destroy
        head 204
      end

      private

      def set_review
        @review = Review.find(params[:id])
      end

      def review_params
        params.permit(:rating, :comment)
      end
    end
  end
end
