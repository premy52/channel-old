class AddLogoFileNameToParents < ActiveRecord::Migration
  def change
    add_column :parents, :logo_file_name, :string
  end
end
