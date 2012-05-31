class ThoughtsController < ApplicationController
  
  def show
    @thought = Thought.find(params[:id])
  end
  
  def create
    # In the future, do a "find_or_create_by" method here to handle duplicates
    @thought = Thought.new(params[:thought])

    Rails.logger.info "!!!!!!!!!!!"
    Rails.logger.info " -> POST"
    Rails.logger.info "!!!!!!!!!!!"
    
    @thought.save!
    
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