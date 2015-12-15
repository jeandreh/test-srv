class Product < ActiveRecord::Base
	has_many :retail_options, dependent: :destroy
	has_many :ingredients, dependent: :destroy
	has_many :supplies, through: :ingredients
	has_and_belongs_to_many :categories

	validates :name, presence: true,
              		 length: { minimum: 5, maximum: 50 }

end
