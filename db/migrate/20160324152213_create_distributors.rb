class CreateDistributors < ActiveRecord::Migration
  def change
    create_table :distributors do |t|
      t.string :distributor_name
      t.string :distributor_contact_first_name
      t.string :distributor_contact_last_name
      t.string :distributor_contact_email
      t.string :distributor_contact_phone
      t.string :distributor_address_1
      t.string :distributor_address_2
      t.string :distributor_city
      t.string :distributor_state
      t.string :distributor_zip
      t.text :distributor_notes

      t.timestamps
    end
  end
end
