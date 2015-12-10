class Admin::WorkingHoursController < Admin::AdminController
  before_action :sanitize_params, only: :create

  def index
    @working_hours = WorkingHour.order(starts_at: :asc).all
  end

  def new
    @working_hour = WorkingHour.new
  end

  def create
    @working_hour = WorkingHour.new(working_hour_params)

    if @working_hour.save
      redirect_to admin_working_hours_path, notice: 'Интервал успешно создан.'
    else
      render :new
    end
  end

  def destroy
    WorkingHour.find(params[:id]).destroy
    redirect_to admin_working_hours_path, notice: 'Интвервал успешно удален.'
  end

  private

  def working_hour_params
    params.require(:working_hour).permit(:start_hour, :start_minute, :end_hour, :end_minute)
  end

  def sanitize_params
    params['working_hour'].each do |key, value|
      params['working_hour'][key] = value.to_i
    end
  end
end
