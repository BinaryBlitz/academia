# == Schema Information
#
# Table name: dishes
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price       :integer
#  image       :string
#  stuff       :boolean          default(FALSE)
#  lunch       :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  subtitle    :string
#  hidden      :boolean          default(FALSE)
#

class Dish < ActiveRecord::Base
  # Schedules
  has_many :schedules, dependent: :destroy
  has_many :days, through: :schedules

  # Orders
  has_many :line_items, dependent: :destroy

  # Ingredients
  has_many :dish_ingredients, dependent: :destroy, inverse_of: :dish
  has_many :ingredients, through: :dish_ingredients
  accepts_nested_attributes_for :dish_ingredients, allow_destroy: true

  # Badges
  has_many :dish_badges, dependent: :destroy, inverse_of: :dish
  has_many :badges, through: :dish_badges
  accepts_nested_attributes_for :dish_badges, allow_destroy: true

  # Validations
  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { greter_than: 0 }
  validates :image, presence: true
  validates :subtitle, presence: true, if: '!stuff && !lunch'
  validates :subtitle, length: { maximum: 60 }

  mount_uploader :image, DishUploader

  scope :dishes, -> { where(stuff: false).where(lunch: false) }
  scope :main, -> { where(stuff: false).where(lunch: false) }
  scope :visible, -> { where(hidden: false) }
  scope :lunches, -> { where(lunch: true) }
  scope :stuff, -> { where(stuff: true) }

  def main?
    !stuff && !lunch
  end
end
