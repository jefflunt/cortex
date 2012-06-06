class Thought < ActiveRecord::Base
  MAX_HISTORY_LENGTH = 5
  
  belongs_to :thought_wall
  has_many :thought_histories, dependent: :destroy, order: 'id DESC'
  
  attr_accessible :thought_wall_id
  attr_accessible :text
  
  validates :thought_wall_id, presence: true
  validates :text,  presence: true
  validates :text,  uniqueness: { :scope => :thought_wall_id }
  
  scope :drag_and_drop_order, order: 'manual_order ASC'
  scope :newest_first, order: 'id DESC'
  scope :oldest_first, order: 'id ASC'
  
  def oldest_history_entry
    # override the ordering to guarantee that we get what we're expecting
    thought_histories.except(:order).order("id DESC").last
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