class Api::V1::AddressbooksController < ApplicationController

  require 'firebase'

  before_action :authenticate_user!
  before_action :user_admin , only: [:create , :update , :destroy ]

  def initialize

    @firebase = Firebase::Client.new('https://api-address-bc407-default-rtdb.firebaseio.com/', ENV['FIREBASE_SECRET_KEY'])
    
  end

  def index

    response =  @firebase.get 'addressbook/contacts/organizations/'

    if response

      render json: { addressbook: response.body }

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[400] }

    end

  end

  def show
  end

  def create

    response = @firebase.push "addressbook/contacts/organizations/#{params[:organization][:id]}/#{params[:name]}", { 

      name: params[:name],
      phone: params[:phone],
      created: Firebase::ServerValue::TIMESTAMP  

    }

    if response

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[201] }

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[400] }

    end

  end

  def update

    response_name =  @firebase.get "addressbook/contacts/organizations/#{params[:organization][:id]}/"

    response = @firebase.update "addressbook/contacts/organizations/#{params[:organization][:id]}/#{response_name.body.first.first}/#{params[:id]}" , {
      name: params[:name],
      phone: params[:phone],
    }

    if response

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[200] }

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[400] }

    end

  end

  def destroy

    response = @firebase.delete "addressbook/contacts/organizations/#{params[:organization][:id]}/#{params[:id]}"

    if response

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[200] }

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[400] }

    end

  end

  def list_organization_contacts

    response =  @firebase.get "addressbook/contacts/organizations/#{params[:id]}"

    if response

      render json: { addressbook: response.body }

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[400] }

    end

  end

  def search_contact_by_name

    response =  @firebase.get "addressbook/contacts/organizations/#{params[:organization_id]}/#{params[:name]}"

    if response

      render json: { addressbook: response.body }

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[400] }

    end

  end

  private

  def user_admin

    if current_user.organization_users.find_by_admin(true).nil?

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[401] }

    end

  end

  def set_addressbook
  end

end
