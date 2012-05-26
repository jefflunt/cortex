class ThoughtWallsController < ApplicationController
  
  def index
  end
  
  def show
    @thought_wall = ThoughtWall.find_by_code(params[:id], :include => :thoughts)
  end
  
  def create
    new_thought_wall = ThoughtWall.new
    new_thought_wall.code = new_unique_code
    new_thought_wall.title = Date.today.strftime('%a, %d %b %Y')
    new_thought_wall.save
    
    redirect_to "/thought_walls/#{new_thought_wall.code}"
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