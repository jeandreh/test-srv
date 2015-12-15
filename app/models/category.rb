class Category < ActiveRecord::Base
	has_and_belongs_to_many :products

	validates :name,	presence: true,
              			length: { minimum: 5, maximum: 50 },
              			uniqueness: true

  validates :description,	presence: true,
              			length: { minimum: 5, maximum: 250 },
              			uniqueness: true
end
