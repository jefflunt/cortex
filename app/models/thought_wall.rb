class ThoughtWall < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :thoughts, :dependent => :destroy
  
  validates :code,  :uniqueness => true
  validates :code,  :presence => true
  validates :title, :presence => true
  
  attr_accessible :title, :custom_layout
  
  def custom_layout
    read_attribute(:custom_layout) || "layout-standard"
  end
  
  def highest_manual_order_value
    last_manually_sorted_thought = thoughts.select("manual_order").order("manual_order DESC").limit(1).first
  
    last_manually_sorted_thought.nil? ? nil : last_manually_sorted_thought.manual_order
  end
  
  def next_manual_order_value
    highest_manual_order_value.nil? ? 0 : highest_manual_order_value + 1
  end
end