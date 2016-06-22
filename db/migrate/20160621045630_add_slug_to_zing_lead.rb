class AddSlugToZingLead < ActiveRecord::Migration
  def change
    add_column :zing_leads, :slug, :string
  end
end
