class Api::V1::ProductsController < ApplicationController
  respond_to :json
  #before_action :authenticate_with_token

  def index
  	render :json => Product.all,
          only: [:id, :name, :image_url],
          include: [ :retail_options => { :only => [ :id, :short_name, :price ] } ],
          status: 200
  end

  def show
  	user = Product.find(params[:id])
    if user
      render :json => user,
            only: [ :id, :name, :image_url ],
            include: [
              { :retail_options => { :only => [ :id, :name, :short_name, :description, :price ] } },
              { :categories => { :only => [ :id, :name, :description ] } },
              { :supplies => { :only => [ :id, :name, :unity ] } }
            ],
            status: 200,
            location: [:api, user]
	  else
	  	render json: { erros: "Invalid parameters" },
	    			status: 422
	  end
  end

end
