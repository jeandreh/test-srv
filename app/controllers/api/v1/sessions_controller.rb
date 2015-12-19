class Api::V1::SessionsController < ApplicationController

	def create
    user_password = session_params[:password]
    user_email = session_params[:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.authenticate user_password
      user.generate_authentication_token!
      user.save
      render json: user, only: [:id, :name, :email, :auth_token],
      			status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
		request_owner = User.find_by(auth_token: params[:id])
		unless request_owner.nil?
		 	request_owner.generate_authentication_token!
		  request_owner.save
		  head 204
		else
			render json: { errors: "Invalid parameters" }, status: :unauthorized
		end
  end

  private

  	def session_params
			params.require(:session).permit(:email, :password, :auth_token)
		end

end
