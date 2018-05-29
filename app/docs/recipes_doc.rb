
module RecipesDoc
  extend BaseDoc

  def self.superclass
    RecipesController
  end

  resource_description do
    resource_id "Recipes"
    formats [:json]
    api_versions "1"
  end

  def_param_group :recipe do
    param :recipe, Hash, required: true, action_aware: true do
      param :name, String, required: true
      param :description, String, required: true
      param :image, :undef, required: true
      param :time, String, required: true
      param :tip, String
      param :category_id, Integer, required: true
      param :ingredients_attributes, Hash, required: true do
        param :name, String
        param :_destroy, :bool
      end
      param :steps_attributes, Hash, required: true do
        param :step, String
        param :_destroy, :bool
      end
    end
  end

  api :GET, "/recipes", "List recipes"
  param :search, String
  param :category, String, desc: "Options: " + Category.all.pluck(:name).join(" | ")
  param :sort, String, desc: "Options: popularity | best"
  param :include, String, desc: "Options: reviews | user | reviews,user"
  param :page, Integer
  param :per_page, Integer
  def index; end

  api :GET, "/recipes/:id", "Show the recipe"
  param :include, String, desc: "Options: reviews | user | reviews,user"
  def show; end

  api :POST, "/recipes", "Create a recipe"
  header "Authentication", "Your JWT TOKEN", required: true
  param_group :recipe
  error code: 401, desc: "Unauthorized"
  error code: 422, desc: "Unprocessable entity"
  def create; end

  api :PATCH, "/recipes/:id", "Update the recipe"
  header "Authentication", "Your JWT TOKEN", required: true
  param_group :recipe
  error code: 401, desc: "Unauthorized"
  error code: 422, desc: "Unprocessable entity"
  def update; end

  api :DELETE, "/recipes/:id", "Delete the recipe"
  header "Authentication", "Your JWT TOKEN", required: true
  error code: 401, desc: "Unauthorized"
  def destroy; end
end
