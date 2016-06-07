class AddBsswToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :bssw, :decimal
  end
end
