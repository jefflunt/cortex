class ThoughtWall < ActiveRecord::Base
  has_many :thoughts, :dependent => :destroy, :order => '(CASE WHEN keep THEN 1 WHEN keep IS NULL THEN 2 ELSE 3 END), updated_at ASC'
  
  validates :code,  :uniqueness => true
  validates :code,  :presence => true
  validates :title, :presence => true
end