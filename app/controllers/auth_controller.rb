class AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate_pin(params[:pin])
      token = JsonWebToken.encode(user_id: user.id)

      render json: {
        message: 'Login successful',
        token: token
      }, status: :ok
    else
      render json: { error: 'Invalid email or pin' }, status: :unauthorized
    end
  rescue => e
    render json: { error: 'Something went wrong' }, status: :internal_server_error
  end
end
