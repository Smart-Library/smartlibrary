module ApplicationHelper
  def active_tab_class(controller)
    params[:controller] == controller ? 'active' : ''
  end
end
