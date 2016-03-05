json.current_time Time.zone.now
json.is_open Day.open?
json.opens_at Day.opens_at

if Day.today
  json.dishes @day.schedules.joins(:dish).where(dish: Dish.main) do |schedule|
    json.partial! 'dish', dish: schedule.dish, out_of_stock: schedule.out_of_stock
  end

  json.lunches @day.schedules.joins(:dish).where(dish: Dish.lunches) do |schedule|
    json.partial! 'dish', dish: schedule.dish, out_of_stock: schedule.out_of_stock
  end

  json.stuff do
    json.partial! 'dish', collection: Dish.stuff.visible, as: :dish, out_of_stock: false
  end
end
