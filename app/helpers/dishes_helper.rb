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
end
