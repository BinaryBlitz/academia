class WorkingHoursController < ApplicationController
  def index
    @working_hours = WorkingHour.all
  end
end
