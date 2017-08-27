class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:email], omniauth_providers: [:facebook, :google_oauth2]

  has_many :recipes
  has_many :user_providers, dependent: :destroy

  validates :username, :email, uniqueness: true

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  # attr_accessor :email, :password, :password_confirmation, :remember_me
end
