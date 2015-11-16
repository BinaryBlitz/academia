module DishesHelper
  def title_for_action(name)
    case name
    when 'lunches'
      'Ланчи'
    when 'stuff'
      'Дополнительное'
    else
      'Блюда'
    end
  end

  def grouped_dishes
    grouped_options = [
      ['Блюда', Dish.dishes.map { |d| [d.name, d.id] } ],
      ['Ланчи', Dish.lunches.map { |d| [d.name, d.id] } ]
    ]
    grouped_options_for_select(grouped_options)
  end
end
