class Admin::AlertsController < Admin::AdminController
  def index
    @menu_present = Day.present_for_the_next_three_days?
    @unassigned = Order.unassigned
    @late = Order.late
  end
end
