json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :description, :subtitle, :price, :image_url, :out_of_stock

  json.ingredients dish.ingredients do |ingredient|
    json.partial! 'api/ingredients/ingredient', ingredient: ingredient
  end

  json.badges dish.badges do |badge|
    json.partial! 'api/badges/badge', badge: badge
  end
end
