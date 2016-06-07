class RemoveFgskuIdFromRecipeversion < ActiveRecord::Migration
  def up
  	remove_column :recipeversions, :fgsku_id
  end
  def down
  	add_column :recipeversions, :fgsku_id, :integer
  end
end
