class Notifier
  def initialize(user, message, options = {})
    return unless user.device_token.present?

    @user = user
    @device_token = user.device_token
    @platform = user.platform
    @message = message
    @options = options

    push
  end

  def push
  return if @message.blank? || @device_token.blank?

  Rails.logger.debug "#{Time.zone.now} Notifying #{@user.id} with message: #{@message}"

  case @platform
    when 'ios' then push_ios_notification
    when 'android' then push_android_notification
    end
  end

  private

  def push_ios_notification
    notification = Houston::Notification.new(
      token: @device_token,
      alert: @message, badge: 1, custom_data: @options
    )
    client.push(notification)

    Rails.logger.debug "#{Time.zone.now} iOS notification: #{@message}, user: #{@user.id}"
  end

  def push_android_notification
    gcm = GCM.new(Rails.application.secrets.gcm_api_key)
    registration_ids = [@device_token]
    options = { notification: { title: 'Статус заказа изменён', body: @message }, data: @options }
    gcm.send(registration_ids, options)

    Rails.logger.debug "#{Time.zone.now} Android notification: #{@message}, user: #{@user.id}"
  end

  def client
    if Rails.application.secrets.apn_environment == 'production'
      Houston::Client.production
    else
      Houston::Client.development
    end
  end
end
