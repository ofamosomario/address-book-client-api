class OrganizationUser < ApplicationRecord

  # RELATIONSHIP
  
  belongs_to :user
  belongs_to :organization

end
