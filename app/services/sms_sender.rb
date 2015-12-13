class SmsSender
  SEND_SMS_ENDPOINT = 'http://sms.ru/sms/send'

  def initialize(phone_number, message)
    @phone_number = phone_number
    @message = message
    send_sms
  end

  private

  def send_sms
    response = HTTParty.post(SEND_SMS_ENDPOINT, body: sms_params).parsed_response

    if response.lines.first.try(:chomp) == '100'
      true
    else
      logger.info "#{Time.zone.now}: SMS to #{phone_number} failed.\n#{response}"
      false
    end
  end

  def sms_params
    {
      api_id: Rails.application.secrets.sms_ru_api_id,
      text: @message,
      to: @phone_number
    }
  end
end
