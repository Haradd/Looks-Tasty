module Api
  module V1
    class RecipesController < ApplicationController
      respond_to :json

      def index
        respond_with Recipe.all
      end

      def show
        respond_with Recipe.find(params[:id])
      end
    end
  end
end
