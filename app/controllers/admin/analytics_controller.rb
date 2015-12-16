class Admin::AnalyticsController < Admin::AdminController
  def index
    @current_period = Analytics.new(current_period)
    @previous_period = Analytics.new(previous_period) if params[:period].present?
  end

  private

  def current_period
    case params[:period]
    when 'day' then 1.day.ago..Time.zone.now
    when 'week' then 1.week.ago..Time.zone.now
    when 'month' then 1.month.ago..Time.zone.now
    when 'year' then 1.year.ago..Time.zone.now
    else nil
    end
  end

  def previous_period
    case params[:period]
    when 'day' then 2.days.ago..1.day.ago
    when 'week' then 2.weeks.ago..1.week.ago
    when 'month' then 2.months.ago..1.month.ago
    when 'year' then 2.years.ago..1.year.ago
    else nil
    end
  end
end
