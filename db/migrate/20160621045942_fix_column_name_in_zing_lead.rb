class FixColumnNameInZingLead < ActiveRecord::Migration
  def change
  	rename_column :zing_leads, :first_hame, :first_name
  	rename_column :zing_leads, :last_hame, :last_name
  end
end
