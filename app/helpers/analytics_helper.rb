module AnalyticsHelper
  def increase_in_percent(previous_value, current_value)
    return 0 if previous_value == 0 || current_value == 0
    ratio = (previous_value.to_f / current_value.to_f) - 1.0
    (100 * ratio).to_i
  end
end
