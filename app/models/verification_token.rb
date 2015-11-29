# == Schema Information
#
# Table name: verification_tokens
#
#  id           :integer          not null, primary key
#  token        :string
#  phone_number :string
#  code         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class VerificationToken < ActiveRecord::Base
  SMS_VERIFICATION_URL = 'http://sms.ru/sms/send'

  before_validation :generate_code
  after_create :send_verification_code

  phony_normalize :phone_number, default_country_code: 'RU'

  validates :code, presence: true
  validates :phone_number, presence: true, phony_plausible: true

  has_secure_token

  def verify(code)
    self.code == code
  end

  def user
    @user ||= User.find_by(phone_number: phone_number)
  end

  def send_verification_code
    response = HTTParty.post(SMS_VERIFICATION_URL, body: sms_verification_params).parsed_response

    if response.lines.first.try(:chomp) == '100'
      true
    else
      logger.info "#{Time.zone.now}: SMS verification for #{phone_number} failed.\n#{response}"
      false
    end
  end

  private

  def generate_code
    self.code = Random.new.rand(1000..9999)
  end

  def sms_verification_params
    {
      api_id: Rails.application.secrets.sms_ru_api_id,
      text: "Код верификации: #{code}",
      to: phone_number
    }
  end
end
