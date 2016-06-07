class MakeStoresAJoinTable < ActiveRecord::Migration
  def up			# make the change
  	add_column :stores, :dc_id, :integer
  end
  def down		#undo the change
  	remove_column :stores, :dc_id
  end
end
