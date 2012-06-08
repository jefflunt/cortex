class AddPositionUpdatedAtToThoughts < ActiveRecord::Migration
  def change
    add_column :thoughts, :position_updated_at, :timestamp, :default => Time.now
  end
end
