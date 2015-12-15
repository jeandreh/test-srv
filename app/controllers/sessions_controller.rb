class SessionsController < ApplicationController

	before_action :authentication_check, :only => [:destroy]

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	log_in user
      redirect_to products_path
    else
      flash.now[:errors] = ['Invalid email/password combination']
      render :new
    end
  end

  def destroy
  	logout
  	redirect_to root_url
  end
end
