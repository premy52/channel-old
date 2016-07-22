class AddOurBannerStoresToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :our_banner_store_count, :integer
  end
end
