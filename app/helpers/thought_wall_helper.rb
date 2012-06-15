module ThoughtWallHelper
  def default_thought_wall_layout
    "layout-standard"
  end
  
  def convert_to_csv(thought_wall)
    csv_string = CSV.generate do |csv| 
      csv << ["Thought", "Votes"] 

      @thought_wall.thoughts.ui_order.each do |thought| 
        csv << [thought.text, thought.score] 
      end
    end 
    
    csv_string.html_safe
  end
end


