class Supply < ActiveRecord::Base
	has_many :ingredients, dependent: :destroy
	has_many :products, through: :ingredients
end
