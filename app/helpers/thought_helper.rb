module ThoughtHelper
  def custom_styles(thought, is_new_thought = false)
    combined_classes = ""
    combined_classes += "new-thought-box " if is_new_thought
    
    if thought.nil?
      combined_classes += "neutral"
    elsif thought.keep?
      combined_classes += "keep"
    elsif thought.neutral?
      combined_classes += "neutral"
    elsif thought.scratch?
      combined_classes += "scratch"
    end
  end
end
