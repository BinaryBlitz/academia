json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :description, :subtitle, :price, :image_url

  json.out_of_stock dish.schedules.on_day(@day).first.out_of_stock

  json.ingredients dish.ingredients do |ingredient|
    json.partial! 'ingredients/ingredient', ingredient: ingredient
  end

  json.badges dish.badges do |badge|
    json.partial! 'badges/badge', badge: badge
  end
end
