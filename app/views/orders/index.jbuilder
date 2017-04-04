json.array!(@orders) do |order|
  json.order do
    json.partial! 'orders/order', order: order

    json.line_items order.line_items do |line_item|
      json.partial! 'line_items/line_item', line_item: line_item

      json.dish do
        json.partial! 'dishes/dish', dish: line_item.dish
      end
    end
  end
end
