class RenamePostionUpdatedAtToManualOrderUpdatedAt < ActiveRecord::Migration
  def change
    rename_column :thoughts, :position_updated_at, :manual_order_updated_at
  end
end
