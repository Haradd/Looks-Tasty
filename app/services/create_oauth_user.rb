class CreateOauthUser
  def initialize(oauth_data, username)
    @oauth_data = oauth_data
    @username = username
  end

  def call
    user = make_new_user
    user.save
    create_user_provider(user)
    user
  end

  private

  def make_new_user
    new_user = User.new(@oauth_data)
    new_user.username = @username
    new_user.password = Devise.friendly_token[0, 20]
    new_user
  end

  def create_user_provider(user)
    UserProvider.create(
      provider: @oauth_data["provider"],
      uid: @oauth_data["uid"],
      user_id: user.id
    )
  end
end
