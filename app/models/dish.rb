class Dish < ActiveRecord::Base
  has_many :schedules, dependent: :destroy
  has_many :days, through: :schedules
  has_and_belongs_to_many :ingredients
end
