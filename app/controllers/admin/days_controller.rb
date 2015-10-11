class Admin::DaysController < Admin::AdminController
  before_action :set_admin_day, only: [:show, :edit, :update, :destroy]

  def index
    @days = Day.all
  end

  def show
  end

  def edit
  end

  def update
    if @day.update(day_params)
      redirect_to [:admin, @day], notice: 'День был успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    redirect_to admin_days_url, notice: 'День был успешно сброшен.'
  end

  private

  def set_admin_day
    @day = Day.find(params[:id])
  end

  def day_params
    params.require(:day).permit(schedules_attributes: [:id, :dish_id, :_destroy])
  end
end
