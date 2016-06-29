class AddListPriceToDc < ActiveRecord::Migration
  def change
    add_column :dcs, :listprice, :decimal
  end
end
