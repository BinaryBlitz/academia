class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  skip_before_action :restrict_access, only: [:create, :authenticate, :authenticate_vk, :authenticate_fb, :send_verification_code]

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

  def authenticate
    @user = User.find_by(sms_verification_params)

    if @user
      @user.update(sms_verification_code: nil)
      render :show
    else
      head :unauthorized
    end
  end

  def authenticate_vk
    if params[:token].present?
      vk = VkontakteApi::Client.new(params[:token])
      @user = User.find_or_create_from_vk(vk)
      render :show
    else
      head 422
    end
  end

  def authenticate_fb
    if params[:token].present?
      graph = Koala::Facebook::API.new(params[:token])
      @user = User.find_or_create_from_fb(graph)
      render :show
    else
      head 422
    end
  end

  def send_verification_code
    User.find_or_initialize_by(phone_number: params[:phone_number]).send_verification_code
    head :created
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password)
  end

  def sms_verification_params
    params.permit(:phone_number, :sms_verification_code)
  end
end
