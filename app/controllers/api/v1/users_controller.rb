class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_by_token

  def show
  	user = User.find(params[:id])
    if user
	    render :json => user, only: [:id, :name, :email],
	    			status: 200, location: [:api, user]
	  else
	  	render json: { erros: "Invalid parameters" },
	    			status: 200, location: [:api, user]
	  end
  end

end
