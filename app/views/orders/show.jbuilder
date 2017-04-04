json.partial! 'order', order: @order

json.line_items @order.line_items do |line_item|
  json.extract! line_item, :id, :quantity

  json.dish do
    json.extract! line_item.dish, :id, :name, :description, :price, :image_url
  end
end

