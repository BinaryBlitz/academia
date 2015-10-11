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

  accepts_nested_attributes_for :schedules, allow_destroy: true

  DAYNAMES_RU = ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота']

  def self.today
    Day.find_by(day_of_week: Date.today.wday)
  end

  def to_s
    DAYNAMES_RU[day_of_week]
  end
end
