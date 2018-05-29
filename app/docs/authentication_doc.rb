module AuthenticationDoc
  extend BaseDoc

  def self.superclass
    AuthenticationController
  end

  api :POST, "/auth/login", "Request for new JWT Token"
  param :email, String, required: true
  param :password, String, required: true
  def authenticate; end
end
