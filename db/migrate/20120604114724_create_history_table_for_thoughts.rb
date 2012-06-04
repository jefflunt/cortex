class CreateHistoryTableForThoughts < ActiveRecord::Migration
  def change
    create_table :thought_histories do |t|
      t.integer :thought_id
      t.text    :text
    end
    
    add_index :thought_histories, :thought_id
  end
end
