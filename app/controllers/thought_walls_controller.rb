require 'csv'

class ThoughtWallsController < ApplicationController
  skip_authorization_check
    
  def export
    @thought_wall = ThoughtWall.find_by_code(params[:id])
    
    respond_to do |format|
      format.csv  {render layout: false}
    end
  end
  
  def show
    @render_timestamp = Time.now.utc.to_i
    
    if params[:since]
      @last_render_at = Time.at(params[:since].to_i).utc
      @thought_wall = ThoughtWall.find_by_code(params[:id])
      @thoughts = Thought.where(["thought_wall_id = ? AND updated_at >= ?", @thought_wall.id, @last_render_at]).order("manual_order_updated_at ASC").includes(:thought_histories)
      
      @update_client_title = @thought_wall.updated_at > @last_render_at
      if @update_client_title || @thoughts.count > 0
        @next_refresh = get_next_refresh(0, true)
      else
        @next_refresh = get_next_refresh(params[:next_refresh].to_i, false)
      end
    else
      @thought_wall = ThoughtWall.find_by_code(params[:id], :include => :thoughts)
      @next_refresh = get_next_refresh(0, true)
    end
    
    cookies[:page_i_was_on] = @thought_wall.code
    
    respond_to do |format|
      format.html
      format.js {render layout: false}
    end
  end
  
  def create
    new_thought_wall = ThoughtWall.new
    new_thought_wall.code = new_unique_code
    new_thought_wall.title = Date.today.strftime('%a, %d %b %Y')
    new_thought_wall.save
    
    redirect_to "/#{new_thought_wall.code}"
  end
  
  def update
    @thought_wall = ThoughtWall.find_by_code(params[:thought_wall][:code])
    @thought_wall.update_attribute(:title, params[:thought_wall][:title])
    
    if current_user
      if params[:thought_wall][:star] == "true"
        @thought_wall.users << current_user unless @thought_wall.users.include?(current_user)
        @star_display = true
      else
        @thought_wall.users.delete(current_user)
        @star_display = false
      end
    end
    
    if params[:thought_wall][:star_clicked] == "true"
      @star_was_clicked = true
    else
      @star_was_clicked = false
    end
  end
  
  private
    def new_unique_code
      new_code = Digest::SHA1.hexdigest(srand.to_s)[0,8]

      while ThoughtWall.find_by_code(new_code)
        new_code = Digest::SHA1.hexdigest(srand.to_s)[0,8]
      end
      
      new_code 
    end
    
    def get_next_refresh(desired_next_refresh, reset_refresh_rate)
      min_refresh = 1500
      return min_refresh if reset_refresh_rate
      
      next_refresh = [desired_next_refresh || min_refresh, min_refresh].max

      next_refresh_in_seconds = (((next_refresh / 1000.0)**2)/30.0)
      next_refresh = [next_refresh + (next_refresh_in_seconds*1000).to_i, 60000].min
    end
  
end