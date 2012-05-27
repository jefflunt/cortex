class ThoughtWall < ActiveRecord::Base
  has_many :thoughts, :dependent => :destroy, :order => 'created_at DESC'
  
  validates :code,  :uniqueness => true
  validates :code,  :presence => true
  validates :title, :presence => true
end