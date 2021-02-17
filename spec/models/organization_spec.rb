require 'rails_helper' 

describe Organization do 

  it "required fields in new organization" do
    
    organization = Organization.new( name: 'Organization - TEST' ) 
   
    expect(organization).to be_valid 

  end

  it 'name required' do

    organization = Organization.create( name: nil )

    organization.valid?

    expect(organization.errors[:name]).to include("can't be blank")

  end

  it 'name size less than 30 chars' do

    organization = Organization.create( name: 'Hi this is a test for organization size name and should be less than 30 chars.' )

    organization.valid?
    
    expect(organization.errors[:name]).to include("is too long (maximum is 30 characters)")

  end
  
end