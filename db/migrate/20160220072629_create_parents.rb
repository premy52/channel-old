class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :corpname
      t.string :hqcity
      t.string :hqstate
      t.string :buyerfirstname
      t.string :buyerlastname
      t.string :ourbrokerfirstname
      t.string :ourbrokerlastname
      t.date :nextreviewdate

      t.timestamps
    end
  end
end
