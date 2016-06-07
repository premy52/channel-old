class RenameVersionsToRecipeversions < ActiveRecord::Migration
  def change
  	rename_table :versions, :recipeversions 
  end
end
