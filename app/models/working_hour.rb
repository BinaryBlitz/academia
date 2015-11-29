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
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :starts_at, :ends_at, overlap: true
end
