json.current_time Time.zone.now
json.is_open Day.open?
json.opens_at Day.opens_at

if Day.today
  json.dishes do
    @day.schedules.joins(:dish).where(dish: Dish.main).each do |schedule|
      json.partial! 'dish', dish: schedule.dish, out_of_stock: schedule.out_of_stock
    end
  end

  json.lunches do
    @day.schedules.joins(:dish).where(dish: Dish.lunches).each do |schedule|
      json.partial! 'dish', dish: schedule.dish, out_of_stock: schedule.out_of_stock
    end
  end

  json.stuff do
    json.partial! 'dish', collection: Dish.stuff, as: :dish, out_of_stock: false
  end
end
