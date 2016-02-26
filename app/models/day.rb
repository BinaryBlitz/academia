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

  has_many :schedules, dependent: :destroy, inverse_of: :day
  has_many :dishes, -> { visible }, through: :schedules

  has_many :courier_schedules, dependent: :destroy, inverse_of: :day
  has_many :couriers, through: :courier_schedules

  accepts_nested_attributes_for :schedules, allow_destroy: true
  accepts_nested_attributes_for :courier_schedules, allow_destroy: true

  validates :date, presence: true, uniqueness: true

  def self.open?
    !!(today.present? && WorkingHour.open_now?)
  end

  def self.opens_at
    return nil if open?

    now = Time.zone.now
    current_minute = now.hour * 60 + now.min
    working_hour = WorkingHour.order(starts_at: :asc).where('starts_at > ?', current_minute).first

    if today.present? && working_hour
      return Time.new(now.year, now.month, now.day, working_hour.hour, working_hour.min)
    end

    earliset = WorkingHour.earliest
    return nil unless next_working_day

    next_working_day.date.to_time.change(hour: earliset.hour, min: earliset.min)
  end

  def self.today
    Day.find_by(date: Date.today)
  end

  def self.present_for_the_next_three_days?
    dates = (1..DAYS_BEFORE_ALERT).map { |day| Date.today + day.days }
    where(date: dates).count == DAYS_BEFORE_ALERT
  end

  def self.next_working_day
    Day.where('date > ?', Date.today).order(date: :asc).first
  end

  def to_s
    I18n.localize(date, format: :long)
  end
end
