class CreateIngredientskus < ActiveRecord::Migration
  def change
    create_table :ingredientskus do |t|
      t.references :ingredient, index: true
      t.boolean :vegan
      t.string :vendor
      t.string :vendorsku
      t.string :description

      t.timestamps
    end
  end
end
