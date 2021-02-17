require 'rails_helper'
require 'shared_contexts'

RSpec.describe Api::V1::OrganizationsController do

  context "#only_admin" do

    it "create need an admin user" do

      user = User.create( email: 'test@test.com' , password: '123123' )

      sign_in user

      post :create, params: { organization: { name: 'Organization - TESTER' } }

      response.body.include?('Unauthorized')

    end

    it "update need an admin user" do

      user = User.create( email: 'test@test.com' , password: '123123' )

      organization = Organization.create( name: 'Organization - TESTER' )

      organization.save

      sign_in user

      put :update, params: { id: organization.id }

      response.body.include?('Unauthorized')

    end

  end

end