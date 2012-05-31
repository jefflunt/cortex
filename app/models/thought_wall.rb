class ThoughtWall < ActiveRecord::Base
  has_many :thoughts, :dependent => :destroy, :order => 'id DESC'
  
  validates :code,  :uniqueness => true
  validates :code,  :presence => true
  validates :title, :presence => true
end