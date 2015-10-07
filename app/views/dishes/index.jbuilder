json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :description, :price, :image_url

  json.ingredients dish.ingredients do |ingredient|
    json.extract! ingredient, :id, :name, :image_url
  end
end
