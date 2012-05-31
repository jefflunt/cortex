class ThoughtsController < ApplicationController
  
  def show
    @thought = Thought.find(params[:id])
  end
  
  def create
    @thought = Thought.new(params[:thought])

    Rails.logger.info "!!!!!!!!!!!"
    Rails.logger.info " -> POST"
    Rails.logger.info "!!!!!!!!!!!"
    
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