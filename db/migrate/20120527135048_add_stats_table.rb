class AddStatsTable < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string  :group
      t.string  :name
      t.integer :value, default: 0
    end
    
    add_index :stats, :group
  end
end
