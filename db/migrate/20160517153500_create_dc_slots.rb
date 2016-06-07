class CreateDcSlots < ActiveRecord::Migration
  def change
  	drop_table :dc_slots 
    create_table :dc_slots do |t|
      t.references :dc, index: true
      t.references :fgsku, index: true
      t.date :authdate
      t.date :dropdate

      t.timestamps
    end
  end
end
