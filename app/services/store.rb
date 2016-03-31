class Store
  DAYS_BEFORE_ALERT = 3

  attr_reader :now, :today

  def initialize
    @now = Time.zone.now
    @current_minute = @now.hour * 60 + @now.min
  end

  def open?
    today.present? && working_now?
  end

  def opens_at
    return if open?
    return format_time(next_working_hour) if working_today? && next_working_hour.present?
    return unless next_working_day.present?

    next_working_day.to_time.change(
      hour: earliest_working_hour.hour, min: earliest_working_hour.min)
  end

  def today
    @today ||= if working_now? || next_working_hour.present?
      Day.find_by(date: Date.today)
    end
  end

  def menu_filled?
    tomorrow = Date.today + 1.day
    date_interval = (tomorrow)..(tomorrow + DAYS_BEFORE_ALERT)
    Day.where(date: date_interval).count == DAYS_BEFORE_ALERT
  end

  private

  def working_now?
    WorkingHour.all.detect { |hour| hour.to_range.include?(@current_minute) }.present?
  end

  def working_today?
    today.present?
  end

  def next_working_day
    @next_working_day ||= Day.where('date > ?', Date.today).order(date: :asc).first
  end

  def earliest_working_hour
    @earliest_working_hour ||= WorkingHour.order(starts_at: :asc).first
  end

  def next_working_hour
    @next_working_hour ||= WorkingHour.order(starts_at: :asc).greater_than(@current_minute).first
  end

  def format_time(working_hour)
    Time.zone.local(@now.year, @now.month, @now.day, working_hour.hour, working_hour.min)
  end
end
