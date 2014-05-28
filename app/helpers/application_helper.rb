module ApplicationHelper
  def is_active(action)
    "active" if params[:action] == action
  end

  def add_links(definition)
    # match the terms that are in { }
    # substitute the {} for links
      # links have search query for the text in the links

    the_match = definition.gsub(/\{(.*?)\}/, "<a href='/tib_terms?search=\\1'>\\1</a>")

  end
end
