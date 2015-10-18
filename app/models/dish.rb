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
  has_many :schedules, dependent: :destroy
  has_many :days, through: :schedules
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :badges

  validates :name, presence: true
  validates :price, presence: true, numericality: { greter_than: 0 }
  validates :image, presence: true
  validates :subtitle, presence: true, if: '!stuff && !lunch'

  accepts_nested_attributes_for :ingredients, allow_destroy: true

  mount_uploader :image, DishUploader

  scope :dishes, -> { where(stuff: true).where(lunch: false) }
  scope :visible, -> { where(hidden: false) }
end
