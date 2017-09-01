class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:email], omniauth_providers: %i[facebook google_oauth2]

  has_many :recipes
  has_many :reviews
  has_many :user_providers, dependent: :destroy

  validates :username, :email, uniqueness: true

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  # attr_accessor :email, :password, :password_confirmation, :remember_me
end
