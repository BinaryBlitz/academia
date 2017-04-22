class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :set_layout

  protected

  def set_layout
    devise_controller? ? 'admin' : false
  end

  def user_not_authorized
    head :forbidden
  end

  def after_sign_in_path_for(resource)
    admin_orders_path
  end
end
