class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :banner, index: true
      t.references :fgsku, index: true

      t.timestamps
    end
  end
end
