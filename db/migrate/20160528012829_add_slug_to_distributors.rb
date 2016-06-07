class AddSlugToDistributors < ActiveRecord::Migration
  def change
    add_column :distributors, :slug, :string
  end
end
