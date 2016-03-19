class Courier::CouriersController < Courier::CourierController
  skip_before_action :restrict_courier_access, only: [:authenticate]

  def authenticate
    @courier = Courier.find_by(phone_number: params[:phone_number])

    if @courier && @courier.authenticate(params[:password])
      render json: { api_token: @courier.api_token }
    else
      render json: { error: 'Invalid phone number / password combination' }, status: :unauthorized
    end
  end

  def update
    if current_courier.update(courier_params)
      head :ok
    else
      render json: current_courier.errors, status: 422
    end
  end

  private

  def courier_params
    params.require(:courier).permit(:device_token, :platform)
  end
end
