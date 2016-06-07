class AddCountryToFgskus < ActiveRecord::Migration
  def change
    add_column :fgskus, :country, :string
  end
end
