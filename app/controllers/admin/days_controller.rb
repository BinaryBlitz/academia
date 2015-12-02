class Admin::DaysController < Admin::AdminController
  before_action :set_admin_day, only: [:show, :edit, :update, :destroy]

  def index
    @days = Day.all
  end

  def show
  end

  def new
    @day = Day.new
  end

  def create
    @day = Day.new(day_params)

    if @day.save
      render :show, notice: 'День был успешно создан.', location: [:admin, @day]
    else
      render :new
    end
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
    @day.destroy
    redirect_to admin_days_url, notice: 'День был успешно сброшен.'
  end

  private

  def set_admin_day
    @day = Day.find(params[:id])
  end

  def day_params
    params.require(:day).permit(:date, schedules_attributes: [:id, :dish_id, :_destroy])
  end
end
