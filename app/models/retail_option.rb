class RetailOption < ActiveRecord::Base
	belongs_to :product
	has_many :compositions
	has_many :ingredients, through: :compositions

	validates :compositions, presence: true

	accepts_nested_attributes_for :compositions, allow_destroy: true

end
