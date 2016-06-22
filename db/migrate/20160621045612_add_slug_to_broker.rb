class AddSlugToBroker < ActiveRecord::Migration
  def change
    add_column :brokers, :slug, :string
  end
end
