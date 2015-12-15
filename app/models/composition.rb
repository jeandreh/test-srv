class Composition < ActiveRecord::Base
  belongs_to :retail_option
  belongs_to :ingredient
end
