class ReplaceHappySadWithVotes < ActiveRecord::Migration
  def up
    add_column :thoughts, :up_votes,   :integer, default: 0
    add_column :thoughts, :down_votes, :integer, default: 0
    
    Thought.reset_column_information
    
    Thought.all.each do |t|
      t.update_attribute(:up_votes, 1)   if t.keep?
      t.update_attribute(:down_votes, 1) if t.scratch?
    end
    
    remove_column :thoughts, :keep
  end

  def down
    add_column    :thoughts, :keep, :boolean
    
    Thought.reset_column_information
    
    Thought.all.each do |t|
      t.update_attribute(:keep, true)  if t.up_votes > t.down_votes
      t.update_attribute(:keep, false) if t.up_votes < t.down_votes
    end
    
    remove_column :thoughts, :up_votes
    remove_column :thoughts, :down_votes
  end
end
