# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  first_name   :string
#  last_name    :string
#  email        :string
#  phone_number :string
#  vk_id        :string
#  fb_id        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  api_token    :string
#  promo_used   :boolean          default(FALSE)
#  balance      :integer          default(0)
#

class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  has_secure_token :api_token

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, phony_plausible: true
  validates :email, email: true

  include Authenticable

  def full_name
    "#{first_name} #{last_name}"
  end
end
