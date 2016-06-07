class AddCountryToDistributors < ActiveRecord::Migration
  def change
    add_column :distributors, :country, :string
  end
end
