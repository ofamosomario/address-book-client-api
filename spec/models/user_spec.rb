require 'rails_helper' 

describe User do 

  it "required fields in new user" do
    
    user = User.new( email: 'mario@gmail.com', password: '123123' ) 
   
    expect(user).to be_valid

  end

  it "password minimum 6 characters in an user" do
    
    user = User.new( email: 'mario@gmail.com', password: '123' ) 
   
    user.valid?

    expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')

  end

  it 'unique email in an user' do

    user = User.create( email: 'mario@gmail.com', password: '123123' )
    
    user = User.create( email: 'mario@gmail.com', password: '123123' )

    user.valid?

    expect(user.errors[:email]).to include('has already been taken')

  end

  it 'validate a valid eMail for user' do

    user = User.create( email: 'mariogmail.com', password: '123123' )

    user.valid?

    expect(user.errors[:email]).to include('is invalid')

  end
  
end