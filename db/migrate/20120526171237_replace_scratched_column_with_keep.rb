class ReplaceScratchedColumnWithKeep < ActiveRecord::Migration
  def change
    remove_column :thoughts, :scratched
    add_column    :thoughts, :keep, :boolean
  end
end
