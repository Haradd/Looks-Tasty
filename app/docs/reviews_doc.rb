module ReviewsDoc
  extend BaseDoc

  def self.superclass
    ReviewsController
  end

  # resource_description do
  #   formats [:json]
  #   api_versions "1"
  # end

  def_param_group :review do
    param :rating, Integer
    param :comment, String
  end

  api :GET, "/reviews/:id", "Show the review"
  def show; end

  api :POST, "/reviews", "Create a review"
  header "Authentication", "Your JWT TOKEN", required: true
  param_group :review
  error code: 401, desc: "Unauthorized"
  error code: 422, desc: "Unprocessable entity"
  def create; end

  api :PATCH, "/reviews/:id", "Update the review"
  header "Authentication", "Your JWT TOKEN", required: true
  param_group :review
  error code: 401, desc: "Unauthorized"
  error code: 422, desc: "Unprocessable entity"
  def update; end

  api :DELETE, "/reviews/:id", "Delete the review"
  header "Authentication", "Your JWT TOKEN", required: true
  error code: 401, desc: "Unauthorized"
  def destroy; end
end
