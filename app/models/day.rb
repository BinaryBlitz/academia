class Day < ActiveRecord::Base
  has_many :schedules, dependent: :destroy
  has_many :dishes, through: :schedules
end
