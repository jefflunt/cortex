class AddLayoutToThoughtWall < ActiveRecord::Migration
  def change
    add_column :thought_walls, :custom_layout, :string, default: nil
  end
end
