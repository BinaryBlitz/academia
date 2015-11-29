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
  OPENS_AT = 0

  has_many :schedules, dependent: :destroy, inverse_of: :day
  has_many :dishes, through: :schedules

  validates :date, presence: true, uniqueness: true

  accepts_nested_attributes_for :schedules, allow_destroy: true

  def self.open?
    Time.use_zone('Moscow') do
      today.present? && WorkingHour.all.find { |hour| (hour.starts_at..hour.ends_at).include?(Time.now.hour) }
    end
  end

  def self.opens_at
    Time.use_zone('Moscow') do
      now = Time.zone.now
      Time.new(now.year, now.month, now.day, OPENS_AT)
    end
  end

  def self.today
    Day.find_by(date: Date.today)
  end

  def to_s
    I18n.localize(date, format: :long)
  end
end
