class Admin::AlertsController < Admin::AdminController
  def index
    @menu_present = Day.present_for_the_next_three_days?
    @unassigned = Order.unassigned.order(created_at: :asc)
    @late = Order.late.order(created_at: :asc)
  end
end
