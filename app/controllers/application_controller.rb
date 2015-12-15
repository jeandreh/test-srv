class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

  def authentication_check
  	if logged_in?
  		return true
  	else
  		redirect_to login_path
  		return false
  	end
  end

end
