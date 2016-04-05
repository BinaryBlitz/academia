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
#  alfa_binding_id       :string
#  card_number           :string
#  promo_code            :string
#  sms_verification_code :integer
#  discount              :integer          default(0)
#  referred_by_id        :integer
#  device_token          :string
#  platform              :string
#

class User < ActiveRecord::Base
  REFERRAL_BONUS = 300
  PROMO_CODE_LENGTH = 6

  before_create :generate_promo_code

  phony_normalize :phone_number, default_country_code: 'RU'

  has_many :orders, dependent: :destroy

  belongs_to :referred_by, class_name: 'User'

  has_secure_token :api_token
  has_secure_token :device_token

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, phony_plausible: true
  validates :email, email: true
  validates :discount, inclusion: { in: 0..20 }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :platform, inclusion: { in: %w(android ios) }, if: 'device_token.present?'
  validate :refers_self

  def full_name
    "#{first_name} #{last_name}"
  end

  def redeem(code)
    return false if promo_used? || code == promo_code

    promo = PromoCode.find_by(code: code)
    return redeem_promo_code(promo) if promo

    user = User.find_by(promo_code: code)
    return update(referred_by: user, balance: balance + REFERRAL_BONUS, promo_used: true) if user

    return false
  end

  def activate_referral_bonus
    return false unless referred_by

    referred_by.update(balance: referred_by.balance + REFERRAL_BONUS)
  end

  private

  def generate_promo_code
    letters = (0..9).to_a + ('a'..'z').to_a
    self.promo_code = letters.sample(PROMO_CODE_LENGTH).join.upcase unless promo_code
  end

  def redeem_promo_code(promo)
    update(balance: balance + promo.discount, promo_used: true)
  end

  def refers_self
    return unless referred_by
    errors.add(:referred_by, 'cannot be equal to self') if self == referred_by
  end
end
