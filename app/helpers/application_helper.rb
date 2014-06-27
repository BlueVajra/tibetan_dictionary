module ApplicationHelper

  def is_active(action)
    "active" if params[:action] == action
  end

  def add_links(definition)
    if definition.match(/\{(.*?)\}/)
      the_strings = definition.match(/\{(.*?)\}/)[1].split(",")
      array_of_tibetan = the_strings.map do |string|
        "<a href='/tib_terms?search=#{string}'>#{to_tibetan(string)}</a>"
      end
      definition.gsub(/\{(.*?)\}/, array_of_tibetan.join(","))
    else
      definition
    end
  end
end
