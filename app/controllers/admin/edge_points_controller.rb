class Admin::EdgePointsController < Admin::AdminController
  def index
    @edge_points = EdgePoint.all
  end

  def new
    @edge_point = EdgePoint.new
  end

  def create
    @edge_point = EdgePoint.new(edge_point_params)

    if @edge_point.save
      redirect_to admin_edge_points_path, notice: 'Точка успешно создана.'
    else
      render :new
    end
  end

  def destroy
    EdgePoint.find(params[:id]).destroy
    redirect_to admin_edge_points_path, notice: 'Точка успешно удалена.'
  end

  private

  def edge_point_params
    params.require(:edge_point).permit(:latitude, :longitude)
  end
end
