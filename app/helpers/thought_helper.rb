module ThoughtHelper
  def keep_class(thought)
    if thought.nil?
      return "neutral"
    elsif thought.keep?
      return "keep"
    elsif thought.neutral?
      return "neutral"
    elsif thought.scratch?
      return "scratch"
    end
  end
end
