class Thought < ActiveRecord::Base
  MAX_HISTORY_LENGTH = 5
  
  belongs_to :thought_wall
  has_many :thought_histories, dependent: :destroy, order: 'id DESC'
  
  attr_accessible :thought_wall_id
  attr_accessible :text
  
  validates :thought_wall_id, presence: true
  validates :text,  presence: true
  validates :text,  uniqueness: { :scope => :thought_wall_id }
  
  scope :drag_and_drop_order,         order: 'manual_order DESC'
  scope :reverse_drag_and_drop_order, order: 'manual_order ASC'
  
  scope :newest_first, order: 'id DESC'
  scope :oldest_first, order: 'id ASC'
  
  def oldest_history_entry
    # override the ordering to guarantee that we get what we're expecting
    thought_histories.except(:order).order("id DESC").last
  end
  
  def determine_new_manual_order_value_from(ui_position)
    siblings.count - ui_position - 1
  end
  
  def reorder_siblings_relative_to(new_manual_order)
    moving_closer_to_front_of_list = (manual_order < new_manual_order)
    
    if moving_closer_to_front_of_list
      thoughts_to_reorder = siblings.drag_and_drop_order.where(["manual_order <= ? AND id NOT IN (?)", new_manual_order, id])
      thoughts_to_reorder.each_with_index do |t, index|
        t.update_attribute(:manual_order, new_manual_order - (index + 1))
      end
    else
      thoughts_to_reorder = siblings.reverse_drag_and_drop_order.where(["manual_order >= ? AND id NOT IN (?)", new_manual_order, id])
      thoughts_to_reorder.each_with_index do |t, index|
        t.update_attribute(:manual_order, new_manual_order + (index + 1))
      end
    end
  end
  
  def siblings
    thought_wall.thoughts
  end
  
  def score
    up_votes - down_votes
  end
  
  def positive_votes?
    up_votes > down_votes
  end
  
  def negative_votes?
    up_votes < down_votes
  end
  
  def neutral_votes?
    up_votes == down_votes
  end
end