class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :registerable,
         :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  # RELATIONSHIP

  has_many :organization_users
  has_many :organizations, through: :organization_users

  accepts_nested_attributes_for :organization_users, allow_destroy: true

  # VALIDATES
  
  validates :email , uniqueness: { allow_blank: false }, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :password , presence: true, length: { minimum: 6 }

  # ENUM

  enum role: {
  	'admin': 0,
  	'normal': 1,
  }

  # CUSTOM METHODS

  before_save :set_default_user_role

  def set_default_user_role

    self.role = 'normal'

  end

end