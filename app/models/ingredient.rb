# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :integer
#

class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :dishes

  validates :name, presence: true
  validates :image, presence: true
  validates :weight, numericality: { greater_than: 0 }, allow_blank: true

  mount_uploader :image, IngredientUploader
end
