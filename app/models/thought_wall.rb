class ThoughtWall < ActiveRecord::Base
  has_many :thoughts, :dependent => :destroy
  
  validates :code,  :uniqueness => true
  validates :code,  :presence => true
  validates :title, :presence => true
  
  def highest_manual_order_value
    thoughts.select("manual_order").order("manual_order DESC").limit(1).first.manual_order
  end
end