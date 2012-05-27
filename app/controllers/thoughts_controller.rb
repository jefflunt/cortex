class ThoughtsController < ApplicationController
  
  def create
    @thought = Thought.new
    @thought.thought_wall_id = params[:thought][:thought_wall_id]
    @thought.text = params[:thought][:text]
    
    Rails.logger.info @thought.valid?
    Rails.logger.info @thought.errors.inspect

    @thought.save!
    # put a conditional here - if the save
    # fails, then it's probably because the
    # thought text is duplicate, which should
    # respond differently with the duplicate
    # thought highlighted
    
    Stat.increment("totals", "thoughts")
  end
  
  def update
    @thought = Thought.find(params[:id], :include => [:thought_wall])
    
    case params[:keep]
    when "keep"
      @thought.keep = true
    when "scratch"
      @thought.keep = false
    when "neutral"
      @thought.keep = nil
    end
    
    @thought.save
  end
  
end