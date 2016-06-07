class AddCountryToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :country, :string
  end
end
