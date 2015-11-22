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
#  promo_code   :string
#

class User < ActiveRecord::Base
  before_create :generate_promo_code

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

  def redeem(promo_code)
    if promo_used?
      false
    else
      update(balance: balance + promo_code.discount, promo_used: true)
    end
  end

  private

  def generate_promo_code
    letters = (0..9).to_a + ('a'..'z').to_a
    self.promo_code = letters.sample(6).join.upcase unless promo_code
  end
end
