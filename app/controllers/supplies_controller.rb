class SuppliesController < ApplicationController

  before_action :authentication_check
  before_action :validate_get_params, only: [:show, :update, :destroy]

  def index
    @supplies = Supply.all
  end

  def show
    @supply = Supply.find(params[:id])
  end

  def new
    @supply = Supply.new
  end

  def create
    if @supply = Supply.create(supply_params)
      redirect_to @supply
    else
      render :new
    end
  end

  def edit
    @supply = Supply.find(params[:id])
  end

  def update
    @supply = Supply.find(params[:id])
    if @supply.update(supply_params)
      redirect_to @supply
    else
      render :edit
    end
  end

  def destroy
     @supply = Supply.destroy(params[:id])
     redirect_to supplies_path
  end

  private

  def supply_params
    params.require(:supply).permit(:name, :price, :stock, :unity)
  end

  def validate_get_params
    unless Supply.exists?(params[:id])
      flash[:errors] = ["Inexistent Supply"]
      redirect_to supplies_path
    end
  end
end
