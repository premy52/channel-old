class AddCountryToDc < ActiveRecord::Migration
  def change
    add_column :dcs, :country, :string
  end
end
