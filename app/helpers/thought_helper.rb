module ThoughtHelper
  def custom_styles(thought, is_new_thought = false)
    combined_classes = ""
    combined_classes += "new-thought-box " if is_new_thought
    
    if thought.nil?
      combined_classes += "neutral"
    elsif thought.positive_votes?
      combined_classes += "positive"
    elsif thought.neutral_votes?
      combined_classes += "neutral"
    elsif thought.negative_votes?
      combined_classes += "negative"
    end
  end
end
