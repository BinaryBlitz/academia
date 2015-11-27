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
#

class User < ActiveRecord::Base
  REFERRAL_BONUS = 100
  PROMO_CODE_LENGTH = 6

  SMS_VERIFICATION_URL = 'http://sms.ru/sms/send'

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

  def redeem(code)
    return false if promo_used?

    promo = PromoCode.find_by(code: code)
    return redeem_promo_code(promo) if promo

    user = User.find_by(promo_code: code)
    return redeem_user_code(promo) if user

    return false
  end

  def send_verification_code
    response = HTTParty.post(SMS_VERIFICATION_URL, body: sms_verification_params).parsed_response

    if response.lines.first.try(:chomp) == '100'
      update(sms_verification_code: @sms_verification_code)
    else
      logger.info "#{Time.zone.now}: SMS verification for #{phone_number} failed.\n#{response}"
      false
    end
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

  def sms_verification_params
    @sms_verification_code = Random.new.rand(1000..9999)

    {
      api_id: Rails.application.secrets.sms_ru_api_id,
      text: "Код верификации: #{@sms_verification_code}",
      to: phone_number
    }
  end
end
