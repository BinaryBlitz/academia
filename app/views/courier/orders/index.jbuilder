json.array! @orders do |order|
  json.partial! 'order', order: order

  json.user do
    json.extract! order.user, :id, :first_name, :last_name, :phone_number
  end

  json.line_items order.line_items do |line_item|
    json.extract! line_item, :id, :quantity

    json.dish do
      json.extract! line_item.dish, :id, :name, :price, :description, :subtitle
    end
  end
end
