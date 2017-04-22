user = User.create!(
  first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com',
  phone_number: '+79991112233', platform: 'ios'
)
user.update!(api_token: 'foobar')

# Ingredients
20.times do
  Ingredient.create!(name: FFaker::Food.ingredient)
end

10.times do
  Badge.create!(
    name: FFaker::HealthcareIpsum.word,
    remote_image_url: 'https://placeholdit.imgix.net/~text?txtsize=9&txt=100×100&w=100&h=100&fm=png'
  )
end

# Categories
3.times do
  Category.create!(name: FFaker::HealthcareIpsum.word)
end

# Dishes
5.times do
  dish = Dish.create!(
    name: FFaker::Food.vegetable,
    category: Category.order('RANDOM()').first,
    description: FFaker::BaconIpsum.sentence,
    subtitle: FFaker::BaconIpsum.words(3).join(' / '),
    price: rand(500) + 1,
    remote_image_url: 'http://lorempixel.com/450/800/food/'
  )
  dish.ingredients << Ingredient.order('RANDOM()').limit(5)
end

EdgePoint.create!(
  [
    { latitude: 0, longitude: 0 },
    { latitude: 0, longitude: 90 },
    { latitude: 90, longitude: 90 },
    { latitude: 90, longitude: 0 },
    { latitude: 0, longitude: 0 }
  ]
)

delivery_point = DeliveryPoint.create!(latitude: 45, longitude: 45)

# Admins
admin = Admin.create!(email: 'foo@bar.com', password: 'qwerty123')

# Couriers
courier = Courier.create!(
  name: 'Courier',
  phone_number: '+79991112233',
  password: 'qwerty123',
  delivery_point: delivery_point
)

promo_code = PromoCode.create!(code: 'PROMO', discount: 10)

order = Order.create!(
  user: user,
  address: 'Address',
  status: :new,
  latitude: 45, longitude: 45,
  rating: 5, review: 'Review',
  line_items_attributes: [{ dish: Dish.first, quantity: 1 }]
)
