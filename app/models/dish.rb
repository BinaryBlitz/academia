class Dish < ActiveRecord::Base
  has_many :schedules, dependent: :destroy
  has_many :days, through: :schedules
end
