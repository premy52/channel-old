class AddDatesToAuthorizations < ActiveRecord::Migration
  def change
    add_column :authorizations, :authdate, :date
    add_column :authorizations, :dropdate, :date
  end
end
