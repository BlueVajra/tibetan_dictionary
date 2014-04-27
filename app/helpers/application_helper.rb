module ApplicationHelper
  def is_active(action)
    "active" if params[:action] == action
  end
end
