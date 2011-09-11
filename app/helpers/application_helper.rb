module ApplicationHelper

  # Return a title on a pre-page basics
  def title
     base_title = "Precision Gaming"
     if @title.nil?
       base_title
     else
       "#{base_title} | #{@title}"
     end
  end

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
end
