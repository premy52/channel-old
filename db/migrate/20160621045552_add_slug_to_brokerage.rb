class AddSlugToBrokerage < ActiveRecord::Migration
  def change
    add_column :brokerages, :slug, :string
  end
end
