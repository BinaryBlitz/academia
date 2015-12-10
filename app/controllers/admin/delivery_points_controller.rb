class Admin::DeliveryPointsController < Admin::AdminController
  def index
    @delivery_points = DeliveryPoint.all
  end

  def new
    @delivery_point = DeliveryPoint.new
  end

  def create
    @delivery_point = DeliveryPoint.new(delivery_point_params)

    if @delivery_point.save
      redirect_to admin_delivery_points_path, notice: 'Пункт доставки успешно создан.'
    else
      render :new
    end
  end

  def destroy
    DeliveryPoint.find(params[:id]).destroy
    redirect_to admin_delivery_points_path, notice: 'Пункт доставки успешно удален.'
  end

  private

  def delivery_point_params
    params.require(:delivery_point).permit(:latitude, :longitude)
  end
end
