# == Schema Information
#
# Table name: dish_badges
#
#  id         :integer          not null, primary key
#  dish_id    :integer
#  badge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DishBadge < ActiveRecord::Base
  belongs_to :dish, inverse_of: :dish_badges
  belongs_to :badge

  validates :dish, presence: true
  validates :badge, presence: true, uniqueness: { scope: :dish }
end
