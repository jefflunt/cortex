class Thought < ActiveRecord::Base
  belongs_to :thought_wall
  
  validates :text,  :presence => true
  validates :text,  :uniqueness => { :scope => :thought_wall_id }  
end