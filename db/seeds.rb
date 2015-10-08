u = User.create!(
  first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com',
  phone_number: '+75551234567', password: 'foobar'
)
u.update!(api_token: 'foobar')

# Ingredients
20.times do
  Ingredient.create!(
    name: FFaker::Food.ingredient,
    remote_image_url: 'http://lorempixel.com/150/150/food/'
  )
end

# Days & schedules
Date::DAYNAMES.each_with_index do |dayname, i|
  day = Day.create!(day_of_week: i)

  5.times do
    dish = day.dishes.create!(
      name: FFaker::Food.vegetable,
      description: FFaker::BaconIpsum.sentence,
      price: rand(500) + 1,
      remote_image_url: 'http://lorempixel.com/450/800/food/'
    )
    dish.ingredients << Ingredient.order('RANDOM()').limit(5)
  end
end

# Lunches
5.times do
  dish = Dish.create!(
    name: FFaker::Food.vegetable,
    description: FFaker::BaconIpsum.sentence,
    price: rand(500) + 1,
    remote_image_url: 'http://lorempixel.com/450/800/food/',
    lunch: true
  )
  dish.ingredients << Ingredient.order('RANDOM()').limit(5)
end

# Stuff
5.times do
  Dish.create!(
    name: FFaker::Food.vegetable,
    description: FFaker::BaconIpsum.sentence,
    price: rand(500) + 1,
    remote_image_url: 'http://lorempixel.com/450/800/food/',
    stuff: true
  )
end
