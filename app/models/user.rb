class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:email], omniauth_providers: %i[facebook google_oauth2]

  has_many :recipes
  has_many :reviews
  has_many :user_providers, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensivity: false }, length: { maximum: 25 },
                       format: { with: /\A[a-zA-Z0-9\-._]+\z/,
                                 message: "Please do not use whitespaces or special characters" }

  validates :email, uniqueness: true

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
end
