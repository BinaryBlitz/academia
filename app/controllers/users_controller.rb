class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  skip_before_action :restrict_access, only: [:create]

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number)
  end

  def sms_verification_params
    params.permit(:phone_number, :sms_verification_code)
  end
end
