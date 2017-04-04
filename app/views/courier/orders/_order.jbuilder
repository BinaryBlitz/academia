json.cache! order do
  json.extract! order,
                :id, :address, :created_at, :total_price,
                :status, :scheduled_for, :latitude, :longitude
end
