class ThoughtsController < ApplicationController
  skip_authorization_check
  
  def show
    @thought = Thought.find(params[:id])
  end
  
  def create
    # In the future, do a "find_or_create_by" method here to handle duplicates
    unless params[:thought][:text].strip.empty?
      @thought = Thought.new(params[:thought])
      @thought.manual_order = @thought.thought_wall.next_manual_order_value
      @thought.save!
    
      Stat.increment("totals", "thoughts")
    end
  end
  
  def edit
    @thought = Thought.find(params[:id])
  end
  
  def update
    @thought = Thought.find(params[:id], :include => [:thought_wall])
    
    if params[:thought]
      if params[:thought][:text]
        ThoughtHistory.create(thought_id: @thought.id, text: @thought.text)
        while @thought.thought_histories.count > Thought::MAX_HISTORY_LENGTH
          @thought.oldest_history_entry.destroy
        end
      
        @thought.text = params[:thought][:text]
      end
      
      if params[:thought][:ui_position]
        new_ui_position = params[:thought][:ui_position].to_i
        new_manual_order = @thought.determine_new_manual_order_value_from(new_ui_position)
        
        @thought.reorder_siblings_relative_to(new_manual_order) unless @thought.manual_order == new_manual_order
        
        @thought.manual_order = new_manual_order
        @thought.manual_order_updated_at = Time.now
      end
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