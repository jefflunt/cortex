class Thought < ActiveRecord::Base
  belongs_to :thought_wall
  
  attr_accessible :thought_wall_id
  attr_accessible :text
  
  validates :thought_wall_id, :presence => true
  validates :text,  :presence => true
  validates :text,  :uniqueness => { :scope => :thought_wall_id }
  
  def keep?
    keep == true
  end
  
  def scratch?
    keep == false
  end
  
  def neutral?
    keep == nil
  end
end