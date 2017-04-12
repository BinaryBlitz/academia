# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :integer
#

class Ingredient < ActiveRecord::Base
  has_many :dish_ingredients, dependent: :destroy

  validates :name, presence: true
  validates :weight, numericality: { greater_than: 0 }, allow_blank: true
end
