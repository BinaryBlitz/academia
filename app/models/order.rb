# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  address    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :user

  has_many :line_items, dependent: :destroy
  accepts_nested_attributes_for :line_items

  validates :user, presence: true
  validates :address, presence: true
end
