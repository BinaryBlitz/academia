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
day = Day.create!(date: Date.today)

5.times do
  dish = Dish.create!(
    name: FFaker::Food.vegetable,
    description: FFaker::BaconIpsum.sentence,
    subtitle: FFaker::BaconIpsum.words(3).join(' / '),
    price: rand(500) + 1,
    remote_image_url: 'http://lorempixel.com/450/800/food/'
  )
  dish.ingredients << Ingredient.order('RANDOM()').limit(5)
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

# Admins
a = Admin.create!(email: 'foo@bar.com', password: 'qwerty123')
