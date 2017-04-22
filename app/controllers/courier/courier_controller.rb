class Courier::CourierController < ApplicationController
  before_action :restrict_access!

  protected

  attr_reader :current_courier
  helper_method :current_courier

  def restrict_access!
    return if restrict_access
    render json: { message: 'Invalid API Token' }, status: 401
  end

  def restrict_access
    @current_courier ||= Courier.find_by_api_token(params[:api_token])
  end

  include Pundit
  protected :pundit_policy_authorized?, :pundit_policy_scoped?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    head :forbidden
  end

  private

  def pundit_user
    current_courier
  end
end
