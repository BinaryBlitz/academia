json.array!(@dishes) do |dish|
  json.extract! dish, :id, :name, :description, :subtitle, :price, :image_url

  if action_name == 'index'
    json.ingredients dish.ingredients do |ingredient|
      json.extract! ingredient, :id, :name, :image_url
    end

    json.badges dish.badges do |badge|
      json.extract! badge, :id, :name, :image_url
    end
  end
end
