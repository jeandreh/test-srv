class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token

  def index
  	render :json => User.all, only: [:id, :name, :email], status: 200
  end

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
