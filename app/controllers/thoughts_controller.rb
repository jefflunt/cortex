class ThoughtsController < ApplicationController
  
  def create
    @thought = Thought.new
    @thought.thought_wall_id = params[:thought][:thought_wall_id]
    @thought.text = params[:thought][:text]
    
    @thought.save!
  end
  
  def update
  end
  
end