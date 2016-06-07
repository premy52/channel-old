class AddDcToBanner < ActiveRecord::Migration
  def change
    add_reference :banners, :dc, index: true
  end
end
