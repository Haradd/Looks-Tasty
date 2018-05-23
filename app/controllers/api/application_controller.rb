module Api
  class ApplicationController < ActionController::Base
    include Response
    include ExceptionHandler

    protect_from_forgery with: :null_session

    attr_reader :current_user

    private

    # Check for valid request token and return user
    def authorize_request
      @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
    end

    def pagination(paginated_array, page, per_page)
      { pagination: { page: page.to_i,
                      per_page: per_page.to_i,
                      total_pages: paginated_array.total_pages,
                      total_objects: paginated_array.total_count } }
    end
  end
end
