class Analytics
  def initialize(period, delivered = true)
    @orders = Order.all
    @orders = Order.where(created_at: period) if period
    @orders = delivered ? @orders.delivered : @orders.rejected
  end

  def new_orders
    user_ids = User.joins(:orders).group('users.id').having('COUNT(orders.id) = ?', 1)
    @orders.where(user_id: user_ids).count
  end

  def repeated_orders
    user_ids = User.joins(:orders).group('users.id').having('COUNT(orders.id) > ?', 1)
    @orders.where(user_id: user_ids).count
  end

  def total_orders
    @orders.count
  end

  def revenue
    @orders.sum(:revenue)
  end

  def discount
    @orders.sum(:discount)
  end

  def balance_discount
    @orders.sum(:balance_discount)
  end

  def total_sum
    revenue + discount + balance_discount
  end
end
