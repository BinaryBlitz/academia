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
  has_many :schedules, dependent: :destroy, inverse_of: :day
  has_many :dishes, through: :schedules

  validates :date, presence: true, uniqueness: true

  accepts_nested_attributes_for :schedules, allow_destroy: true

  # FIXME: Apply order
  def self.today
    Day.where('date <= ?', Date.today).first
  end

  def to_s
    I18n.localize(date, format: :long)
  end
end
