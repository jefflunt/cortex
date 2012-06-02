class ThoughtWallsController < ApplicationController
    
  def show
    @render_timestamp = Time.now.utc.to_i
    
    if params[:since]
      last_render_at = Time.at(params[:since].to_i).utc
      @thought_wall = ThoughtWall.find_by_code(params[:id])
      @thoughts = Thought.where(["thought_wall_id = ? AND updated_at >= ?", @thought_wall.id, last_render_at]).order("id DESC")
      
      @update_client_title = @thought_wall.updated_at > last_render_at
      if @update_client_title || @thoughts.count > 0
        @next_refresh = get_next_refresh(0, true)
      else
        @next_refresh = get_next_refresh(params[:next_refresh].to_i, false)
      end
    else
      @thought_wall = ThoughtWall.find_by_code(params[:id], :include => :thoughts)
      @next_refresh = get_next_refresh(0, true)
    end
    
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
    @thought_wall = ThoughtWall.find(params[:id])
    @thought_wall.update_attribute(:title, params[:thought_wall][:title])
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