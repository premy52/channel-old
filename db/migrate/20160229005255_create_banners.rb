class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :banner_name
      t.string :banner_city
      t.string :banner_state
      t.string :banner_buyer_first_name
      t.string :banner_buyer_last_name
      t.string :banner_broker_first_name
      t.string :banner_broker_last_name
      t.date :banner_review_date
      t.integer :banner_store_count
      t.text :banner_notes
      t.string :logo_file_name
      t.references :parent, index: true

      t.timestamps
    end
  end
end
