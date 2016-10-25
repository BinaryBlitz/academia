Alfabank.setup do |config|
  config.username = Rails.application.secrets.alfabank_username
  config.password = Rails.application.secrets.alfabank_password
  config.language = 'ru'
  config.return_url = Rails.application.secrets.alfabank_return_url
  config.currency = Alfabank::Currency::RUB
  config.order_number_prefix = 'test-payment-'
  config.binding_username = Rails.application.secrets.alfabank_binding_username
  config.binding_password = Rails.application.secrets.alfabank_binding_password
  config.mode = (Rails.application.secrets.alfabank_mode == 'production' ? :production : :test)
end

Alfabank.logger = Rails.logger
