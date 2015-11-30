# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  first_name            :string
#  last_name             :string
#  email                 :string
#  phone_number          :string
#  vk_id                 :string
#  fb_id                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  api_token             :string
#  promo_used            :boolean          default(FALSE)
#  balance               :integer          default(0)
#  promo_code            :string
#  alfa_binding_id       :string
#  card_number           :string
#  sms_verification_code :integer
#  discount              :integer          default(0)
#

class User < ActiveRecord::Base
  REFERRAL_BONUS = 100
  PROMO_CODE_LENGTH = 6

  before_create :generate_promo_code

  phony_normalize :phone_number, default_country_code: 'RU'

  has_many :orders, dependent: :destroy

  has_secure_token :api_token

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, phony_plausible: true
  validates :email, email: true
  validates :discount, inclusion: { in: 0..100 }

  def full_name
    "#{first_name} #{last_name}"
  end

  def redeem(code)
    return false if promo_used?

    promo = PromoCode.find_by(code: code)
    return redeem_promo_code(promo) if promo

    user = User.find_by(promo_code: code)
    return redeem_user_code(promo) if user

    return false
  end

  private

  def generate_promo_code
    letters = (0..9).to_a + ('a'..'z').to_a
    self.promo_code = letters.sample(PROMO_CODE_LENGTH).join.upcase unless promo_code
  end

  def redeem_user_code(referred_user)
    referred_user.update(balance: referred_user.balance + REFERRAL_BONUS)
    update(balance: balance + REFERRAL_BONUS, promo_used: true)
  end

  def redeem_promo_code(promo)
    update(balance: balance + promo.discount, promo_used: true)
  end
end
