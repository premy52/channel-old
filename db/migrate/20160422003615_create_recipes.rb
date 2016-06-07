class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.references :flavor, index: true

      t.timestamps
    end
  end
end
