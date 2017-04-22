# == Schema Information
#
# Table name: days
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  date       :date
#

class Day < ActiveRecord::Base
  DAYS_BEFORE_ALERT = 3

  has_many :dishes, -> { visible }, through: :schedules

  accepts_nested_attributes_for :schedules, allow_destroy: true
  accepts_nested_attributes_for :courier_schedules, allow_destroy: true

  validates :date, presence: true, uniqueness: true

  def to_s
    I18n.localize(date, format: :long)
  end

  def to_time
    date.to_time.in_time_zone(Time.zone.name)
  end
end
