# == Schema Information
#
# Table name: dishes
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  price         :integer
#  image         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  subtitle      :string
#  hidden        :boolean          default(FALSE)
#  proteins      :float
#  fats          :float
#  carbohydrates :float
#  calories      :float
#  category_id   :integer
#

class Dish < ActiveRecord::Base
  belongs_to :category

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

  has_many :lunch_dishes, dependent: :destroy, inverse_of: :dish
  accepts_nested_attributes_for :lunch_dishes, allow_destroy: true

  # Validations
  validates :category, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { greter_than: 0 }
  validates :image, presence: true
  validates :subtitle, length: { maximum: 60 }

  validates :proteins, :fats, :carbohydrates, :calories,
            presence: true, numericality: { greater_than: 0 }, if: 'has_nutrition_info?'

  mount_uploader :image, DishUploader

  scope :visible, -> { where(hidden: false) }
  scope :visible, -> { where(hidden: false) }

  def has_nutrition_info?
    proteins || fats || carbohydrates || calories
  end
end
