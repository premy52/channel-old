class CreateFgskus < ActiveRecord::Migration
  def change
    create_table :fgskus do |t|
      t.references :flavor, index: true
      t.string :sizegroup
      t.decimal :weightoz
      t.integer :innercount
      t.integer :outercount
      t.string :upc
      t.string :innerupc
      t.string :outerupc
      t.text :comment

      t.timestamps
    end
  end
end
