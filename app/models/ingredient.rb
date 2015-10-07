# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :dishes

  validates :name, presence: true
  validates :image, presence: true

  mount_uploader :image, IngredientUploader
end
