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

  validates :day_of_week, presence: true, inclusion: 0..6, uniqueness: true

  def self.today
    Day.find_by(day_of_week: Date.today.wday)
  end
end
