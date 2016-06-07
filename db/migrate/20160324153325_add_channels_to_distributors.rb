class AddChannelsToDistributors < ActiveRecord::Migration
  def change
    add_column :distributors, :channel_segment, :string
  end
end
