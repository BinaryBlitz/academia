json.current_time Time.zone.now
json.is_closed Day.open?
json.opens_at Day.opens_at

if Day.open?
  json.dishes do
    json.partial! 'dish', collection: @day.dishes.main, as: :dish
  end

  json.lunches do
    json.partial! 'dish', collection: @day.dishes.lunches, as: :dish
  end

  json.stuff do
    json.partial! 'dish', collection: Dish.stuff, as: :dish
  end
end
