json.cache! dish do
  json.extract! dish,
                :id, :name, :description, :subtitle, :price, :image_url,
                :proteins, :fats, :carbohydrates, :calories
end
