class Admin::DaysController < Admin::AdminController
  before_action :set_admin_day, only: [:show, :edit, :update, :destroy]

  def index
    @days = Day.all
  end

  def show
  end

  def edit
  end

  def create
    @day = Day.new(admin_day_params)

    if @day.save
      redirect_to @day, notice: 'Day was successfully created.'
    else
      render :new
    end
  end

  def update
    if @day.update(admin_day_params)
      redirect_to @day, notice: 'Day was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    redirect_to admin_days_url, notice: 'Day was successfully destroyed.'
  end

  private

  def set_admin_day
    @day = Day.find(params[:id])
  end

  def admin_day_params
    params.require(:day)
  end
end
