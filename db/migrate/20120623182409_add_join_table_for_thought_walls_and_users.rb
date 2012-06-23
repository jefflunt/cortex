class AddJoinTableForThoughtWallsAndUsers < ActiveRecord::Migration
  def change
    create_table :thought_walls_users, :id => false do |t|
      t.references :thought_wall
      t.references :user
    end
    add_index :thought_walls_users, [:thought_wall_id, :user_id]
    add_index :thought_walls_users, [:user_id, :thought_wall_id]
  end
end
