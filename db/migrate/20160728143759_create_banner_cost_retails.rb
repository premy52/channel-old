class CreateBannerCostRetails < ActiveRecord::Migration
  def change
    create_table :banner_cost_retails do |t|
      t.date :eff_date
      t.decimal :realcost
      t.decimal :regretail
      t.references :banner, index: true

      t.timestamps
    end
  end
end
