class AddPriorityToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :priority, :integer
  end
end
