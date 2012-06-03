class ResetVotesOfNegativeOneToZero < ActiveRecord::Migration
  def up
    Thought.all.each do |t|
      if t.up_votes - t.down_votes == -1
        t.up_votes = 0
        t.down_votes = 0
        t.save
      end
    end
  end

  def down
    # We don't need to reverse this. It's a one-time, forward only issue
    # to correct a bug in the previous migration.
  end
end
