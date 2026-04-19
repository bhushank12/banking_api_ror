class ApplicationController < ActionController::API
  before_action :authorize_request

  private
  def authorize_request
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    return render json: { error: 'Missing token' }, status: :unauthorized unless token

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::ExpiredSignature
      render json: { error: 'Token has expired' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :unauthorized
    end
  end
end
