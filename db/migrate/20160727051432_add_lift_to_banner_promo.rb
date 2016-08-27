class AddLiftToBannerPromo < ActiveRecord::Migration
  def change
    add_column :banner_promos, :lift, :decimal
  end
end
