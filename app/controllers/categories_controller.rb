class CategoriesController < ApplicationController

  before_action :authentication_check
  before_action :validate_get_params, only: [:show, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    if @category = Category.create(category_params)
      redirect_to @category
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
     @category = Category.destroy(params[:id])
     redirect_to categories_path
  end

private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def validate_get_params
    unless Category.exists?(params[:id])
      flash[:errors] = ["Inexistent category"]
      redirect_to categories_path
    end
  end

end
