module Api
  module V1
    class RecipesController < ApplicationController
      respond_to :json

      def index
        recipes = Recipe.filter(filter_params).page(params[:page]).per(params[:per_page])
        render json: recipes, include: params[:include], meta: pagination(recipes, params[:page], params[:per_page])
      end

      def show
        render json: Recipe.find(params[:id]), include: params[:include]
      end

      private

      def filter_params
        params.permit(:search, :category, :sort)
      end
    end
  end
end
