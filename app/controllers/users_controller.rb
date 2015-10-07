class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  skip_before_action :restrict_access, only: [:create, :authenticate, :authenticate_vk, :authenticate_fb]

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
    @user = User.find(params[:id])

    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def authenticate
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      render json: { id: @user.id, api_token: @user.api_token }
    else
      render json: { error: 'Invalid email / password combination' }, status: :unauthorized
    end
  end

  def authenticate_vk
    if params[:token].present?
      vk = VkontakteApi::Client.new(params[:token])
      @user = User.find_or_create_from_vk(vk)
      render json: { id: @user.id, api_token: @user.api_token }
    else
      head 422
    end
  end

  def authenticate_fb
    if params[:token].present?
      graph = Koala::Facebook::API.new(params[:token])
      @user = User.find_or_create_from_fb(graph)
      render json: { id: @user.id, api_token: @user.api_token }
    else
      head 422
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password)
  end
end
