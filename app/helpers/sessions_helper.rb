module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logout
  	session.delete(:user_id)
    @current_user = nil
  end

  # REST API authentication
  def authenticate_by_token
    request_owner = User.find_by(auth_token: request.headers['Authorization'])
    unless request_owner.nil?
      log_in request_owner
    else
      render json: { errors: "Invalid transaction" }, status: :unauthorized
    end
  end

end
