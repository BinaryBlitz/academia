class Admin::CouriersController < Admin::AdminController
  before_action :set_courier, only: [:show, :edit, :update, :destroy]

  def index
    @couriers = Courier.all.page(params[:page])
  end

  def show
  end

  def new
    @courier = Courier.new
  end

  def create
    @courier = Courier.new(courier_params)

    if @courier.save
      redirect_to admin_couriers_path, notice: 'Курьер успешно создан.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @courier.update(courier_params)
      redirect_to admin_couriers_path, notice: 'Курьер успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @courier.destroy
    redirect_to admin_couriers_path, notice: 'Курьер успешно удален.'
  end

  private

  def set_courier
    @courier = Courier.find(params[:id])
  end

  def courier_params
    params.require(:courier).permit(:name, :phone_number, :password, :delivery_point_id)
  end
end
