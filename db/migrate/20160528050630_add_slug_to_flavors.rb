class AddSlugToFlavors < ActiveRecord::Migration
  def change
    add_column :flavors, :slug, :string
  end
end
