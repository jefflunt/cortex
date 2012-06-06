class ThoughtsController < ApplicationController
  
  def show
    @thought = Thought.find(params[:id])
  end
  
  def create
    # In the future, do a "find_or_create_by" method here to handle duplicates
    @thought = Thought.new(params[:thought])
    @thought.manual_order = @thought.thought_wall.next_manual_order_value
    @thought.save!
    
    Stat.increment("totals", "thoughts")
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
        #determine new manual order
        ui_position = params[:thought][:ui_position].to_i
        new_manual_order = @thought.thought_wall.thoughts.count - ui_position - 1
        
        #re-order
        thoughts_to_reorder = @thought.thought_wall.thoughts.drag_and_drop_order.where(["manual_order <= ? AND id NOT IN (?)", new_manual_order, @thought.id])
        thoughts_to_reorder.each_with_index do |t, index|
          t.update_attribute(:manual_order, new_manual_order - (index + 1))
        end
        
        #assign new order to modified thought
        @thought.manual_order = new_manual_order
        
        Rails.logger.info "!!!!!!!!!!!!!!"
        Rails.logger.info "total items     : #{@thought.thought_wall.thoughts.count}"
        Rails.logger.info "highest order   : #{@thought.thought_wall.highest_manual_order_value}"
        Rails.logger.info "new UI position : #{ui_position}"
        Rails.logger.info "new manual_order: #{new_manual_order}"
        Rails.logger.info "!!!!!!!!!!!!!!"
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