module Api
  class AuthenticationController < Api::ApplicationController
    # before_action :authorize_request, except: :authenticate

    def authenticate
      auth_token =
        AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
      render json: { auth_token: auth_token }
    end

    private

    def auth_params
      params.permit(:email, :password)
    end
  end
end
