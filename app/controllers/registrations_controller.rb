class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create

    @user = User.new(user_params)
    
    if @user.save
      
      render json: { status: Rack::Utils::HTTP_STATUS_CODES[201] }

    else

      render json: { errors: @user.errors }

    end

  end

  private

  def user_params

    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :role,
      organization_users_attributes: [ :id , :user_id , :organization_id ],
      organizations_attributes: [ :id ]
    )

  end
end