class Api::V1::CategoriesController < ApplicationController
  respond_to :json
  #before_action :authenticate_with_token

  def index
  	render :json => Category.all,
          only: [:id, :name],
          status: 200
  end

  def show
  	cat = Category.find(params[:id])
    if user
      render :json => cat,
            only: [ :id, :name, :description ],
            status: 200,
            location: [:api, cat]
	  else
	  	render json: { erros: "Invalid parameters" },
	    			status: 422
	  end
  end

end
