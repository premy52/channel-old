class CreateDcCostLists < ActiveRecord::Migration
  def change
    create_table :dc_cost_lists do |t|
      t.date :eff_date
      t.decimal :receivedcost
      t.decimal :listprice
      t.references :dc, index: true

      t.timestamps
    end
  end
end
