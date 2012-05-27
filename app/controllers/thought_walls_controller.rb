class ThoughtWallsController < ApplicationController
  
  def index
    thought_count_stat      = Stat.find_by_group_and_name("totals", "thoughts")
    thought_wall_count_stat = Stat.find_by_group_and_name("totals", "thought_walls")
    @thought_count      = thought_count_stat.nil?      ? 0 : thought_count_stat.value
    @thought_wall_count = thought_wall_count_stat.nil? ? 0 : thought_wall_count_stat.value
  end
  
  def show
    @thought_wall = ThoughtWall.find_by_code(params[:id], :include => :thoughts)
  end
  
  def create
    new_thought_wall = ThoughtWall.new
    new_thought_wall.code = new_unique_code
    new_thought_wall.title = Date.today.strftime('%a, %d %b %Y')
    new_thought_wall.save
    
    Stat.increment("totals", "thought_walls")
    
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
  
end