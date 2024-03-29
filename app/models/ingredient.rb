# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dish_id    :integer
#

class Ingredient < ActiveRecord::Base
  validates :name, presence: true
end
