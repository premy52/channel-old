class AddStoreNameToStores < ActiveRecord::Migration
  def change
    add_column :stores, :store_name, :string
  end
end
