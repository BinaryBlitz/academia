module AnalyticsHelper
  def increase(previous, current)
    return 0 if previous == 0 || current == 0
    ratio = (previous.to_f / current.to_f) - 1.0
    (100 * ratio).to_i
  end
end
