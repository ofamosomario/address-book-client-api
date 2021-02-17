class Api::V1::OrganizationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :update, :destroy, :is_admin?]
  before_action :is_admin?, only: [:update, :delete]

  def index

    @organizations = current_user.organizations

    render json: @organizations

  end

  def show
    render json: @organization
  end

  def create
    
    @organization = Organization.new(organization_params)

    if @organization.save

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[200] }

    else

      render json: @organization.errors, status: Rack::Utils::HTTP_STATUS_CODES[422]

    end

  end

  def update

    if @organization.update(organization_params)

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[200] }

    else

      render json: @organization.errors, status: Rack::Utils::HTTP_STATUS_CODES[422]

    end
  end

  def destroy

    @organization.destroy

  end

  def register_as_admin

    if current_user.organization_users.present?
    
      role = current_user.organization_users.find_by_organization_id(params[:organization_id])
      
      if role.update_attribute(:admin , true)

        render json: { status: Rack::Utils::HTTP_STATUS_CODES[200] }

      else

        render json: { status: Rack::Utils::HTTP_STATUS_CODES[422] }

      end

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[400] }

    end

  end

  private

  def is_admin?

    admin_organizations = current_user.organization_users.find_by_organization_id(@organization.id)

    if ( current_user.organizations.present? ) && admin_organizations.admin?
    
      true

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[401] }
    
    end
  
  end

  def set_organization

    @organization = Organization.find(params[:id])

  end

  def organization_params

    params.require(:organization).permit(:name)
    
  end
  
end
