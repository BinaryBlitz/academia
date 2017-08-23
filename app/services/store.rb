class Store
  DAYS_BEFORE_ALERT = 3

  attr_reader :now

  def initialize
    @now = Time.zone.now
    @current_minute = @now.hour * 60 + @now.min
  end

  def open?
    WorkingHour.all.detect { |hour| hour.to_range.include?(@current_minute) }.present?
  end

  def opens_at
    return if open?
    return format_time(next_working_hour) if next_working_hour.present?

    1.day.from_now.change(hour: earliest_working_hour.hour, min: earliest_working_hour.min)
  end

  def welcome_screen_image_url
    welcome_screen = WelcomeScreen.instance

    if open?
      welcome_screen.image_open_url if welcome_screen.image_open_enabled?
    else
      welcome_screen.image_closed_url if welcome_screen.image_closed_enabled?
    end
  end

  private

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
