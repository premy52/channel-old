class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :maintype
      t.string :form
      t.string :subform

      t.timestamps
    end
  end
end
