class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.date :logdate
      t.text :log_notes
      t.string :outcome
      t.string :review
      t.string :action
      t.date :actiondate
      t.string :action_status
      t.references :parent, index: true
      t.references :banner, index: true
      t.references :distributor, index: true
      t.references :dc, index: true
      t.references :broker, index: true
      t.references :manager, index: true
      t.references :store, index: true

      t.timestamps
    end
  end
end
