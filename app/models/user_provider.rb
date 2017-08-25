class UserProvider < ActiveRecord::Base
  belongs_to :user



  def self.find_for_facebook_oauth(auth)
    user = UserProvider.where(provider: auth.provider, uid: auth.uid).first

    if user.nil?
      registered_user = User.where(email: auth.info.email).first

      if registered_user.nil?
        new_user = create_user(auth)

        create_user_provider(auth, new_user)
        new_user
      else
        create_user_provider(auth, user)
        registered_user
      end
    else
      user.user
    end
  end

private
  def self.create_user(auth)
    user = User.create(username: auth.info.name,
                 email: auth.info.email,
                 password: Devise.friendly_token[0, 20])
  end

  def self.create_user_provider(auth, user)
    UserProvider.create!(
      provider: auth.provider,
      uid: auth.uid,
      user_id: user.id
    )
  end
end
