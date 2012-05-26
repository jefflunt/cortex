class InitialSchema < ActiveRecord::Migration
  def change
    create_table :thought_walls do |t|
      t.string  :code
      t.string  :title

      t.timestamps
    end
    
    add_index :thought_walls, :code, :unique => true
        
    create_table :thoughts do |t|
      t.integer :thought_wall_id
      t.text    :text
      t.boolean :scratched, :default => false
      
      t.timestamps
    end
  end
end
