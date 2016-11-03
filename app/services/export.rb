class Export
  def initialize(from = Date.new(2015, 1, 1), to = Date.today + 1.day)
    @orders = Order.all
    @orders = @orders.where(scheduled_for: from..(to + 1.day)) if from.present? && to.present?
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << header

      @orders.includes(:line_items).each do |order|
        order.line_items.each do |line_item|
          csv << row_for(order, line_item)
        end
      end
    end
  end

  private

  def header
    [
      'Дата', 'Точка продаж', 'Покупатель',
      'Номер заказа', 'Название блюда или ланча',
      'Количество', 'Сумма'
    ]
  end

  def row_for(order, line_item)
    [
      order.created_at.to_s, order.delivery_point_id,
      order.user.phone_number, order.id,
      "#{line_item.dish.name} : #{line_item.dish_id}", line_item.quantity,
      line_item.total_price
    ]
  end
end
