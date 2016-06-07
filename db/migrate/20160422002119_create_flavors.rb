class CreateFlavors < ActiveRecord::Migration
  def change
    create_table :flavors do |t|
      t.string :shorthand
      t.string :descriptor
      t.boolean :coated

      t.timestamps
    end
  end
end
