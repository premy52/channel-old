class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.references :fgsku, index: true
      t.integer :versionyear
      t.integer :versionmonth
      t.text :comment
      t.string :filmfilename
      t.string :caddyfilename
      t.string :imagefilename

      t.timestamps
    end
  end
end
