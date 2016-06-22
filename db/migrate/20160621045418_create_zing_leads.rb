class CreateZingLeads < ActiveRecord::Migration
  def change
    create_table :zing_leads do |t|
      t.string :first_hame
      t.string :last_hame
      t.string :title
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
