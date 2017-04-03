json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :description, :subtitle, :price, :image_url

  json.ingredients dish.ingredients do |ingredient|
    json.extract! ingredient, :id, :name
  end

  json.badges dish.badges do |badge|
    json.extract! badge, :id, :name, :image_url
  end
end
