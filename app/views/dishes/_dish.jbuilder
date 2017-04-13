json.cache! dish do
  json.extract! dish,
                :id, :name, :description, :subtitle, :price, :image_url,
                :proteins, :fats, :carbohydrates, :calories

  json.out_of_stock dish.schedules.first.out_of_stock
end
