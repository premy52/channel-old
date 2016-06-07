class AddSlugToDcs < ActiveRecord::Migration
  def change
    add_column :dcs, :slug, :string
  end
end
