class Courier::CourierController < ApplicationController
  skip_before_action :restrict_access

  protected

  attr_reader :current_user
  helper_method :current_user

  def restrict_access
    unless restrict_access_by_params
      render json: { message: 'Invalid API Token' }, status: 401
      return
    end
  end

  def restrict_access_by_params
    return true if @current_courier

    @current_courier = Courier.find_by_api_token(params[:api_token])
  end
end
