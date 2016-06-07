class AddRankToFlavor < ActiveRecord::Migration
  def change
    add_column :flavors, :rank, :integer
  end
end
