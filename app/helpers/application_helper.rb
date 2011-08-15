module ApplicationHelper

  # Return a title on a pre-page basics
  def title
     base_title = "Ruby on Rails Tutorial Sample App"
     if @title.nil?
       base_title
     else
       "#{base_title} | #{@title}"
     end
  end
end
