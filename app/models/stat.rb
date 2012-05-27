class Stat < ActiveRecord::Base
  validates :group, :presence => true
  validates :name,  :presence => true
  validates :value, :presence => true
  
  def self.increment(group, name)
    stat = Stat.find_by_group_and_name(group, name)
    stat.update_attribute(:value, stat.value+1) unless stat.nil?
  end
end