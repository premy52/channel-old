class Recipe < ActiveRecord::Base
  belongs_to :flavor
  has_many :ingredients	
  has_many :recipeversions
end
