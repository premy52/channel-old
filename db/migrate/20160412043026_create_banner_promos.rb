class CreateBannerPromos < ActiveRecord::Migration
  def change
    create_table :banner_promos do |t|
      t.date :start_date
      t.date :end_date
      t.string :promo_vehicle
      t.string :promo_method
      t.decimal :promo_level
      t.string :status
      t.string :comment
      t.references :banner, index: true

      t.timestamps
    end
  end
end
