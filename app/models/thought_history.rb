class ThoughtHistory < ActiveRecord::Base
  belongs_to :thought
  
  validates :thought_id, :presence => true
  validates :text,  :presence => true
  
  attr_accessible :thought_id
  attr_accessible :text
end