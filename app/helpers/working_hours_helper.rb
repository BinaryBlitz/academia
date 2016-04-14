module WorkingHoursHelper
  def start_time_from_working_hour(working_hour)
    "#{working_hour.starts_at / 60} ч #{working_hour.starts_at % 60} мин"
  end

  def end_time_from_working_hour(working_hour)
    "#{working_hour.ends_at / 60} ч #{working_hour.ends_at % 60} мин"
  end
end
