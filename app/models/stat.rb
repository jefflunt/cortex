class Stat < ActiveRecord::Base
  validates :group, :presence => true
  validates :name,  :presence => true
  validates :value, :presence => true
  
  def self.increment(group, name)
    stat = get_stat(group, name)
    stat.update_attribute(:value, stat.value+1) unless stat.nil?
  end
  
  def self.get_stat(group, name)
    Stat.find_by_group_and_name(group, name)
  end
  
  def self.get_value(group, name)
    stat = get_stat(group, name)
    stat.nil? ? 0 : stat.value
  end
end