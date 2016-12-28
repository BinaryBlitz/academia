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
    SmsSender.new(phone_number, "Код верификации: #{code}")
  end

  def as_json(options)
    { phone_number: phone_number, token: token }
  end

  private

  def generate_code
    # self.code = Random.new.rand(1000..9999)
    self.code = 1111
  end
end
