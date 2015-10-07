json.array!(@days) do |day|
  json.extract! day, :id, :day_of_week
  json.url day_url(day, format: :json)
end
