# == Schema Information
#
# Table name: courier_schedules
#
#  id         :integer          not null, primary key
#  day_id     :integer
#  courier_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CourierSchedule < ActiveRecord::Base
  belongs_to :day, inverse_of: :courier_schedules
  belongs_to :courier

  validates :day, presence: true
  validates :courier, presence: true
  validates :courier, uniqueness: { scope: :day }
end
