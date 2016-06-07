class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.references :banner, index: true

      t.timestamps
    end
  end
end
