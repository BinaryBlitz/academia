json.array! @orders do |order|
  json.partial! 'api/orders/order', order: order

  json.user do
    json.partial! 'api/users/user', user: order.user
  end

  json.line_items order.line_items do |line_item|
    json.partial! 'api/line_items/line_item', line_item: line_item

    json.dish do
      json.partial! 'api/dishes/dish', dish: line_item.dish
    end
  end
end
