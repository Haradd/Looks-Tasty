class UsersController < ApplicationController
  before_action :require_finishing_oauth_sign_up,
                 only: %i[finish_oauth_sign_up configure_profile]
  before_action :check_if_signed_in, only: :recipes

  def recipes
    pages = 15
    @recipes = current_user.recipes
    @recipes = @recipes.page(params[:page]).per(pages).decorate
  end

  # GET /users/finish_sign_up
  def finish_oauth_sign_up
    @user = User.new(session["devise.new_user"])
  end

  # POST /users/finish_sign_up
  def configure_profile
    @user = User.new(session["devise.new_user"])
    @user.username = user_params[:username]
    @user.password = Devise.friendly_token[0, 20]

    if @user.save
      auth = session["devise.oauth_data"]
      UserProvider.create!(
        provider: auth["provider"],
        uid: auth["uid"],
        user_id: @user.id
      )

      sign_in_and_redirect @user, event: :authentication
    else
      render :finish_oauth_sign_up
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

  def require_finishing_oauth_sign_up
    return if session["devise.new_user"].present?
    redirect_to recipes_path, notice: "Sorry, something went wrong!"
  end

  def check_if_signed_in
    return if current_user.present?
    redirect_to recipes_path, notice: "Sorry, that recipes are not yours!"
  end
end
