class AddFieldToRecipeversions < ActiveRecord::Migration
  def change
    add_reference :recipeversions, :recipe, index: true
  end
end
