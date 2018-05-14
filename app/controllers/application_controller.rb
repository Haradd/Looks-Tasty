class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def authenticate_user!(opts = {})
    if user_signed_in?
      super
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "Please sign in first" }
      end
    end
  end

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[email password]
  end

  def pagination(paginated_array, page, per_page)
    { pagination: { page: page.to_i,
                    per_page: per_page.to_i,
                    total_pages: paginated_array.total_pages,
                    total_objects: paginated_array.total_count } }
  end
end
