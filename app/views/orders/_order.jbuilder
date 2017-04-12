json.cache! order do
  json.extract! order,
                :id, :address, :created_at, :total_price, :line_items_price,
                :status, :scheduled_for, :latitude, :longitude,
                :rating, :review
end
