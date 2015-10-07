# == Schema Information
#
# Table name: days
#
#  id          :integer          not null, primary key
#  day_of_week :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Day < ActiveRecord::Base
  has_many :schedules, dependent: :destroy
  has_many :dishes, through: :schedules
end
