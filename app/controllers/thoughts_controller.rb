class ThoughtsController < ApplicationController
  
  def create
    @thought = Thought.new
    @thought.thought_wall_id = params[:thought][:thought_wall_id]
    @thought.text = params[:thought][:text]
    
    @thought.save!
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