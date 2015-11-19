# == Schema Information
#
# Table name: dish_ingredients
#
#  id            :integer          not null, primary key
#  dish_id       :integer
#  ingredient_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DishIngredient < ActiveRecord::Base
  belongs_to :dish, inverse_of: :dish_ingredients
  belongs_to :ingredient

  validates :dish, presence: true
  validates :ingredient, presence: true, uniqueness: { scope: :dish }
end
