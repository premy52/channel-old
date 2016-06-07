class CreateDcs < ActiveRecord::Migration
  def change
    create_table :dcs do |t|
      t.string :dc_name
      t.string :dc_contact_first_name
      t.string :dc_contact_last_name
      t.string :dc_contact_email
      t.string :dc_contact_phone
      t.string :dc_address_1
      t.string :dc_address_2
      t.string :dc_city
      t.string :dc_state
      t.string :dc_zip
      t.text :dc_notes
      t.references :distributor, index: true

      t.timestamps
    end
  end
end
