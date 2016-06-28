class AddBrokerToBanner < ActiveRecord::Migration
  def change
    add_reference :banners, :broker, index: true
  end
end
