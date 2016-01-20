Alfabank.setup do |config|
  config.username = 'zdorovoepitanie-api'
  config.password = 'zdorovoepitanie'
  config.language = 'ru'
  config.return_url = 'finish.html'
  config.error_url = 'error.html'
  config.currency = Alfabank::Currency::RUB
  config.order_number_prefix = 'test-payment-'
  config.binding_username = 'zdorovoepitanie_auto-api'
  config.mode = :test # :production
end
