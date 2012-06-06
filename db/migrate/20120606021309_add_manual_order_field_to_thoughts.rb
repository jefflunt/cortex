class AddManualOrderFieldToThoughts < ActiveRecord::Migration
  def up
    add_column :thoughts, :manual_order, :integer
    
    Thought.reset_column_information
    
    ThoughtWall.all.each_with_index do |tw|
      thoughts = tw.thoughts.except(:order).order("id ASC")
      thoughts.each_with_index do |t, index|
        t.update_attribute(:manual_order, index)
      end
    end
  end
  
  def down
    remove_column :thoughts, :manual_order
  end
end
