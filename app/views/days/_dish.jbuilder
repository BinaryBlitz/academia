json.extract! dish, :id, :name, :description, :subtitle, :price, :image_url

if dish.main? || dish.lunch?
  json.ingredients dish.ingredients do |ingredient|
    json.extract! ingredient, :id, :name, :image_url
  end

  json.badges dish.badges do |badge|
    json.extract! badge, :id, :name, :image_url
  end
end
