class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = UserProvider.find_for_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.oauth_data"] = request.env["omniauth.auth"]
      session["devise.new_user"] = @user.attributes
      redirect_to users_finish_sign_up_url
    end
  end

  def google_oauth2
    @user = UserProvider.find_for_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.oauth_data"] = request.env["omniauth.auth"]
      session["devise.new_user"] = @user.attributes
      redirect_to users_finish_sign_up_url
    end
  end
end
