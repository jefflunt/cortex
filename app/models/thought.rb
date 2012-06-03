class Thought < ActiveRecord::Base
  belongs_to :thought_wall
  
  attr_accessible :thought_wall_id
  attr_accessible :text
  
  validates :thought_wall_id, :presence => true
  validates :text,  :presence => true
  validates :text,  :uniqueness => { :scope => :thought_wall_id }
  
  def score
    up_votes - down_votes
  end
  
  def positive_votes?
    up_votes > down_votes
  end
  
  def negative_votes?
    up_votes < down_votes
  end
  
  def neutral_votes?
    up_votes == down_votes
  end
end