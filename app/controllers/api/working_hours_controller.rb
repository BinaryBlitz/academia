class API::WorkingHoursController < API::APIController
  def index
    @working_hours = WorkingHour.all
  end
end
