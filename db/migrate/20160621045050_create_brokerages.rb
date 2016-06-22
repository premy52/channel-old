class CreateBrokerages < ActiveRecord::Migration
  def change
    create_table :brokerages do |t|
      t.string :company
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.decimal :rate

      t.timestamps
    end
  end
end
