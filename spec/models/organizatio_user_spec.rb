require 'rails_helper' 

describe OrganizationUser do 

  it "required fields in new organization user" do
    
    organization = Organization.new( name: 'Organization - TEST' ) 
    organization.save

    user = User.create( email: 'test@test.com' , password: '123123' )
    user.save

    OrganizationUser.create( user_id: user.id , organization_id: organization.id , admin: true )
   
    expect(organization).to be_valid 

  end

  it "fk is required" do
    
    organization_user = OrganizationUser.create( user_id: nil , organization_id: nil )
   
    expect(organization_user).not_to be_valid

  end
  
end