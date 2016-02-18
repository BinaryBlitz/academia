json.extract! dish,
              :id, :name, :description, :subtitle, :price, :image_url,
              :proteins, :fats, :carbohydrates, :calories, :out_of_stock

if dish.main? || dish.lunch?
  if dish.lunch?
    json.ingredients dish.lunch_dishes do |lunch_dish|
      json.extract! lunch_dish, :id, :name, :weight
      json.image_url nil
    end
  else
    json.ingredients dish.ingredients do |ingredient|
      json.extract! ingredient, :id, :name, :weight, :image_url
    end
  end

  json.badges dish.badges do |badge|
    json.extract! badge, :id, :name, :image_url
  end
end
