class Ingredient < ActiveRecord::Base
	belongs_to :product
	belongs_to :supply
	has_many :compositions, dependent: :destroy
end
