json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :description, :price, :image

  json.ingredients dish.ingredients do |ingredient|
    json.extract! ingredient, :id, :name, :image
  end
end
