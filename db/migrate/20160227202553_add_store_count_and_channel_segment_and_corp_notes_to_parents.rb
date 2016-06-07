class AddStoreCountAndChannelSegmentAndCorpNotesToParents < ActiveRecord::Migration
  def change
    add_column :parents, :store_count, :integer
    add_column :parents, :channel_segment, :string
    add_column :parents, :corp_notes, :text
  end
end
