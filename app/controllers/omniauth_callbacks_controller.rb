class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provide_callback_for(provider)
    class_eval %{
      def #{provider}
        @user = UserProvider.find_for_oauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
        else
          session["devise.oauth_data"] = request.env["omniauth.auth"].except(:extra)
          session["devise.new_user"] = @user.attributes
          redirect_to users_finish_sign_up_url
        end
      end
    }
  end

  %i[facebook google_oauth2].each do |provider|
    provide_callback_for(provider)
  end
end
