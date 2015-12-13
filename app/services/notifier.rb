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

    Rails.logger.debug "#{Time.zone.now} Notifying #{@user} with message: #{@message}"

    case @platform
    when 'android'
      push_android_notification
    when 'ios'
      push_ios_notification
    end
  end

  private

  def push_android_notifications
    return if @message.blank? || @device_token.blank?

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name('android_app')
    n.registration_ids = [@device_token]
    n.data = { message: @message }.merge(@options)
    n.save!

    Rails.logger.debug "#{Time.zone.now} GCM notification: #{@message}, user: #{@user.id}"
  end

  def push_ios_notification
    n = Rpush::Apns::Notification.new
    n.app = Rpush::Apns::App.find_by_name('ios_app')
    n.device_token = @device_token
    n.alert = @message
    n.data = @options
    n.save!

    Rails.logger.debug "#{Time.zone.now} iOS notification: #{@message}, user: #{@user.id}"
  end
end
