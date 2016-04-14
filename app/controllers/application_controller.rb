class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :restrict_access

  # Devise configuration
  skip_before_filter :restrict_access, if: :devise_controller?
  layout :set_layout

  attr_reader :current_user
  helper_method :current_user

  def restrict_access
    unless restrict_access_by_params
      render json: { message: 'Invalid API Token' }, status: 401
      return
    end
  end

  def restrict_access_by_params
    return true if @current_user

    @current_user = User.find_by_api_token(params[:api_token])
  end

  protected

  def set_layout
    devise_controller? ? 'admin' : false
  end

  include Pundit
  protected :pundit_policy_authorized?, :pundit_policy_scoped?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    head :forbidden
  end

  def after_sign_in_path_for(resource)
    admin_orders_path
  end
end
