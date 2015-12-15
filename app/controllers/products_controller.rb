require 'fileutils'

class ProductsController < ApplicationController

	before_action :authentication_check

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
		respond_to do |format|
  		format.html # show.html.erb
	  	format.json { render :json => @product }
		end
	end

	def new
		@product = Product.new
		@product.retail_options.build
	end

	def edit
		@product = Product.find(params[:id])
		@product.retail_options.build
	end

	def create
		@product = Product.new
		if build_from_request(@product)
			redirect_to @product
		else
			render :new
		end
	end

	def update
		@product = Product.find(params[:id])
		if build_from_request(@product)
			redirect_to @product
		else
			render :edit
		end
	end

	def destroy
		@product = Product.destroy(params[:id])
		redirect_to products_path
	end

	private

		def build_from_request(prod)
			@product.name = product_params[:name]
			load_categories @product
			load_ingredients @product
			handle_image_upload @product
			@product.save
		end

		def load_categories(prod)
			cat_ids = product_params[:categories]
			prod.categories = Array.new
			cat_ids.reject(&:blank?).each do |cat_id|
				prod.categories.push(Category.find(cat_id))
			end
		end

		def load_ingredients(prod)
			ing_ids = product_params[:ingredients]
			prod.ingredients = Array.new
			ing_ids.reject(&:blank?).each do |ing_id|
				sup = Supply.find(ing_id)
				unless (sup == nil || prod.supplies.include?(sup))
					prod.ingredients.push(Ingredient.new(supply_id: ing_id))
				end
			end
		end

		def handle_image_upload(prod)
			img_file = product_params[:img_file]
			prod_name = product_params[:name]
			img_url = nil
			if img_file && img_file.content_type == "image/jpeg"
				dest_path = "public/imgs/" + prod_name + DateTime.now.to_s + ".jpg"
				FileUtils.mv(img_file.path, dest_path)
				img_url = dest_path
				prod.image_url = img_url
			end
		end

		def product_params
			params.require(:product).permit(:name, :img_file,
				:categories => [], :ingredients => [])
		end

end
