class RenumberAllManualOrderValues < ActiveRecord::Migration
  def up
    ThoughtWall.all.each_with_index do |tw|
      thoughts = tw.thoughts.except(:order).order("id ASC")
      thoughts.each_with_index do |t, index|
        t.update_attribute(:manual_order, index)
      end
    end
  end

  def down
  end
end
