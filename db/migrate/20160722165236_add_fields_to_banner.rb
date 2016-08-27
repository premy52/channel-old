class AddFieldsToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :bar_regular_retail, :decimal
    add_column :banners, :caddy_actual_cost, :decimal
  end
end
