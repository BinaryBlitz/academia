class Admin::AlertsController < Admin::AdminController
  def index
    @menu_present = Store.new.menu_filled?
    @unassigned = Order.unassigned.order(created_at: :asc)
    @late = Order.late.order(created_at: :asc)
  end
end
