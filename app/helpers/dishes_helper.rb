# == Schema Information
#
# Table name: dishes
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  price         :integer
#  image         :string
#  stuff         :boolean          default(FALSE)
#  lunch         :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  subtitle      :string
#  hidden        :boolean          default(FALSE)
#  proteins      :float
#  fats          :float
#  carbohydrates :float
#  calories      :float
#  out_of_stock  :boolean          default(FALSE)
#

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
    [
      ['Блюда', Dish.dishes.map { |d| ["#{d.name}: #{d.id}", d.id] } ],
      ['Ланчи', Dish.lunches.map { |d| ["#{d.name}: #{d.id}", d.id] } ]
    ]
  end
end
