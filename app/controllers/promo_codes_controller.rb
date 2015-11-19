class PromoCodesController < ApplicationController
  def redeem
    @promo_code = PromoCode.find_by!(code: params[:code])

    if current_user.redeem(@promo_code)
      head :ok
    else
      render json: { error: 'Promo code already used.' }, status: 422
    end
  end
end
