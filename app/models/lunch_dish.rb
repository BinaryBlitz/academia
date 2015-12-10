# == Schema Information
#
# Table name: lunch_dishes
#
#  id         :integer          not null, primary key
#  name       :string
#  weight     :integer
#  dish_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LunchDish < ActiveRecord::Base
  belongs_to :dish, inverse_of: :lunch_dishes

  validates :dish, presence: true
  validates :name, presence: true
  validates :weight, presence: true
end
