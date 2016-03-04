# == Schema Information
#
# Table name: schedules
#
#  id           :integer          not null, primary key
#  day_id       :integer
#  dish_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  out_of_stock :boolean          default(FALSE)
#

class Schedule < ActiveRecord::Base
  belongs_to :day, inverse_of: :schedules
  belongs_to :dish

  validates :day, presence: true
  validates :dish, presence: true
  validates :dish, uniqueness: { scope: :day }
end
