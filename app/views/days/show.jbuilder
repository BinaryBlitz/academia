json.current_time @store.now
json.is_open @store.open?
json.opens_at @store.opens_at
json.welcome_screen_image_url @store.welcome_screen_image_url

if @store.today
  json.dishes @store.today.schedules.joins(:dish).where(dish: Dish.main) do |schedule|
    json.partial! 'dish', dish: schedule.dish, out_of_stock: schedule.out_of_stock
  end

  json.lunches @store.today.schedules.joins(:dish).where(dish: Dish.lunches) do |schedule|
    json.partial! 'dish', dish: schedule.dish, out_of_stock: schedule.out_of_stock
  end

  json.stuff do
    json.partial! 'dish', collection: Dish.stuff.visible, as: :dish, out_of_stock: false
  end
end
