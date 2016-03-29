module ApplicationHelper
  def page_needs_refresh?
    admin_signed_in? && controller_name == 'orders' && action_name == 'index'
  end
end
