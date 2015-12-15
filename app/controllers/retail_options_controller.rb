class RetailOptionsController < ApplicationController

  before_action :authentication_check
  before_action :validate_get_params, only: [:show, :update, :destroy]

  def index
  end

  def show
    @product = Product.find(params[:product_id])
    @retail_option = @product.retail_options.find(params[:id])
  end

  def new
    @product = Product.find(params[:product_id])
    @retail_option = @product.retail_options.new
    @product.ingredients.each do |ingredient|
      composition = @retail_option.compositions.new
      composition.ingredient = ingredient
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @retail_option = @product.retail_options.create(retail_option_params)
    if @retail_option.persisted?
      redirect_to @product
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @retail_option = @product.retail_options.find(params[:id])
  end

  def update
    @product = Product.find(params[:product_id])
    ro = @product.retail_options.find(params[:id])
    ro.update(retail_option_params);
    redirect_to @product
  end

  def destroy
    @product = Product.find(params[:product_id])
    @product.retail_options.destroy(params[:id])
    redirect_to @product
  end

private

  def retail_option_params
    params.require(:retail_option).permit(:name, :short_name,
        :description, :price, compositions_attributes: [ :id, :ingredient_id, :quantity ])
  end

  def validate_get_params
    unless RetailOption.exists?(product_id: params[:product_id], id: params[:id])
      unless Product.exists?(params[:product_id])
        flash[:errors] = ["Retail option inexistent for specified product"]
        redirect_to @product
      end
      flash[:errors] = ["Specified product does not exist"]
      redirect_to products_path
    end
  end

  # EXAMPLE
  # retail_option_params = {
  #   "name" => "Large",
  #   "short_name" => "L",
  #   "description" => "Black Coffee Large (200ml)",
  #   "price" => "5",
  #   "compositions_attributes" => {
  #     "0" => {
  #       "ingredient_id" => "6",
  #       "quantity" => "0.002"
  #     },
  #     "1" => {
  #       "ingredient_id" => "7",
  #       "quantity" => "0.00001"
  #     }
  #   }
  # }

end
