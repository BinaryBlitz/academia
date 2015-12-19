class Analytics
  def initialize(period, delivered = true)
    @orders = Order.all
    @orders = Order.where(created_at: period) if period
    @orders = delivered ? @orders.delivered : @orders.rejected
  end

  def new_orders
    return @new_orders if @new_orders
    users = User.joins(:orders).group('users.id').having('COUNT(orders.id) = ?', 1)
    @new_orders = @orders.where(user: users).count
  end

  def repeated_orders
    return @repeated_orders if @repeated_orders
    users = User.joins(:orders).group('users.id').having('COUNT(orders.id) > ?', 1)
    @repeated_orders = @orders.where(user: users).count
  end

  def total_orders
    @total_orders ||= @orders.count
  end

  def revenue
    @revenue ||= @orders.sum(:revenue)
  end

  def discount
    @discount ||= @orders.sum(:discount)
  end

  def balance_discount
    @balance_discount ||= @orders.sum(:balance_discount)
  end

  def total_sum
    @total_sum ||= revenue + discount + balance_discount
  end

  def average_sum
    return 0 if @orders.count == 0
    revenue / @orders.count
  end

  def average_delivery_time
    return @average_delivery_time if @average_delivery_time
    delivered_orders = @orders.delivered.pluck(:created_at, :delivered_at)
    return 0 if delivered_orders.count == 0
    @average_delivery_time = delivered_orders.map { |order| order[1] - order[0] }.sum / delivered_orders.count
  end

  def repeated_orders_for_unique_users
    return @repeated_orders_for_unique_users if @repeated_orders_for_unique_users
    return if User.count == 0
    users = User.joins(:orders).group('users.id').having('COUNT(orders.id) > ?', 2)
    @repeated_orders_for_unique_users = (users.count.size.to_f / User.count) * 100
  end
end
