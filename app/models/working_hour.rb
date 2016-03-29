# == Schema Information
#
# Table name: working_hours
#
#  id         :integer          not null, primary key
#  starts_at  :integer
#  ends_at    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WorkingHour < ActiveRecord::Base
  before_validation :convert_values

  attr_accessor :start_hour, :start_minute
  attr_accessor :end_hour, :end_minute

  validates :start_hour, :end_hour, :start_minute, :end_minute, inclusion: { in: 0...60 }
  validates :starts_at, :ends_at, presence: true
  validates :starts_at, :ends_at, overlap: true

  scope :greater_than, -> (minute) { where('starts_at > ?', minute) }

  def from
    "#{starts_at / 60} ч #{starts_at % 60} мин"
  end

  def to
    "#{ends_at / 60} ч #{ends_at % 60} мин"
  end

  def hour
    starts_at / 60
  end

  def min
    starts_at % 60
  end

  def to_range
    starts_at..ends_at
  end

  private

  def convert_values
    self.starts_at = @start_hour * 60 + @start_minute
    self.ends_at = @end_hour * 60 + @end_minute
  end
end
