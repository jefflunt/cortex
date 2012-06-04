class ThoughtsController < ApplicationController
  
  def show
    @thought = Thought.find(params[:id])
  end
  
  def create
    # In the future, do a "find_or_create_by" method here to handle duplicates
    @thought = Thought.new(params[:thought])
    @thought.save!
    
    Stat.increment("totals", "thoughts")
  end
  
  def edit
    @thought = Thought.find(params[:id])
  end
  
  def update
    @thought = Thought.find(params[:id], :include => [:thought_wall])
    
    if params[:thought] and params[:thought][:text]
      ThoughtHistory.create(thought_id: @thought.id, text: @thought.text)
      while @thought.thought_histories.count > Thought::MAX_HISTORY_LENGTH
        @thought.oldest_history_entry.destroy
      end
      
      @thought.text = params[:thought][:text]
    end
    
    case params[:vote]
    when "up"
      @thought.up_votes += 1
    when "down"
      @thought.down_votes += 1
    end
    
    @thought.save
  end
  
end