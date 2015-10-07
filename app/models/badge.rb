# == Schema Information
#
# Table name: badges
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Badge < ActiveRecord::Base
  has_and_belongs_to_many :dishes

  validates :name, presence: true
  validates :image, presence: true
end
