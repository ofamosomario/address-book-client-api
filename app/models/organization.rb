class Organization < ApplicationRecord

    # RELATIONSHIP

    has_many :organization_users
    has_many :users, through: :organization_users

    # VALIDATES
    
    validates :name , presence: true, length: { maximum: 30 }

end
