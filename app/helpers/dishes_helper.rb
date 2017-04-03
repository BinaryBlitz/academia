module DishesHelper
  def grouped_dishes
    [
      ['Блюда', Dish.all.map { |dish| ["#{dish.name}: #{dish.id}", dish.id] } ]
    ]
  end
end
