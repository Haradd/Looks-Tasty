module RegistrationsDoc
  extend BaseDoc

  def self.superclass
    RegistrationsController
  end

  api :POST, "/signup", "Sign up"
  param :email, String, required: true
  param :password, String, required: true
  param :password_confirmation, String, required: true
  def create; end
end
