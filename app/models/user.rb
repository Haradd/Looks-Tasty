class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:email]

  has_many :recipes

  validates :username,  :email, uniqueness: true

 # Virtual attribute for authenticating by either username or email
 # This is in addition to a real persisted field like 'username'
 #attr_accessor :email, :password, :password_confirmation, :remember_me


end
