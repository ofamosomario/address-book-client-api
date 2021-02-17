class Api::V1::AuthenticationController < ApiController

  def create

    user = User.find_by( email: params[:email] )

    if user&.valid_password?( params[:password] )

      render json: { token: JsonWebToken.encode( sub: user.id ) }

    else

      render json: { status: Rack::Utils::HTTP_STATUS_CODES[401] }

    end
    
  end

  def fetch

    render json: current_user

  end

end