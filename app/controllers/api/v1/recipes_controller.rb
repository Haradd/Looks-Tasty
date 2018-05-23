module Api
  module V1
    class RecipesController < Api::ApplicationController
      before_action :authorize_request, except: %i[index show]

      def index
        recipes = Recipe.includes(:category).includes(:user).filter(filter_params).page(params[:page]).per(params[:per_page])
        render json: recipes, include: params[:include], meta: pagination(recipes, params[:page], params[:per_page])
      end

      def show
        render json: Recipe.find(params[:id]), include: params[:include]
      end

      def create
        recipe = current_user.recipes.build(recipe_params)
        if recipe.save
          render json: recipe, status: 201
        else
          render json: { errors: recipe.errors }, status: 422
        end
      end

      def update
        recipe = current_user.recipes.find(params[:id])
        if recipe.update(recipe_params)
          render json: recipe, status: 200, location: [:api, recipe]
        else
          render json: { errors: recipe.errors }, status: 422
        end
      end

      def destroy
        recipe = current_user.recipes.find(params[:id])
        recipe.destroy
        head 204
      end

      private

      def filter_params
        params.permit(:search, :category, :sort)
      end

      def recipe_params
        params.require(:recipe).permit(:name, :description, :image, :time, :tip,
        :portions, :category_id, ingredients_attributes: %i[id name _destroy],
                                 steps_attributes: %i[id step _destroy])
      end
    end
  end
end
