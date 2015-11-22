class PromoCodesController < ApplicationController
  def redeem
    if current_user.redeem(params[:code])
      head :ok
    else
      render json: { error: 'Promo code already used.' }, status: 422
    end
  end
end
