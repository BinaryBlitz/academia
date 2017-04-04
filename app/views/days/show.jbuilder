json.current_time @store.now
json.is_open @store.open?
json.opens_at @store.opens_at
json.welcome_screen_image_url @store.welcome_screen_image_url

if @store.today
  json.dishes @store.today.schedules do |schedule|
    json.partial! 'dish', dish: schedule.dish, out_of_stock: schedule.out_of_stock

    json.ingredients schedule.dish.ingredients do |ingredient|
      json.extract! ingredient, :id, :name, :weight
    end

    json.badges schedule.dish.badges do |badge|
      json.extract! badge, :id, :name, :image_url
    end
  end
end
