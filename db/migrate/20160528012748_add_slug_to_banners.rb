class AddSlugToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :slug, :string
  end
end
