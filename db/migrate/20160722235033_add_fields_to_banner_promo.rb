class AddFieldsToBannerPromo < ActiveRecord::Migration
  def change
    add_column :banner_promos, :bar_feature_price, :decimal
    add_column :banner_promos, :performance, :string
  end
end
