source 'https://rubygems.org'

ruby '~> 2.4.1'

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'jbuilder', '~> 2.6'

# Front-end
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'

# Auth
gem 'devise', '~> 4.2'
gem 'pundit', '~> 1.1'

# Views
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'devise-bootstrap-views', '~> 1.0.0.alpha1'
gem 'nested_form_fields', '~> 0.8'
gem 'bootstrap-datepicker-rails', '~> 1.6'

# Image processing
gem 'carrierwave', '~> 1.0'
gem 'mini_magick', '~> 4.6'

# I18n
gem 'rails-i18n', '~> 5.0'
gem 'devise-i18n', '~> 1.1'
gem 'devise-i18n-views', '~> 0.3'
gem 'kaminari-i18n', '~> 0.4'

# Utilities
gem 'kaminari', '~> 0.17'
gem 'email_validator', '~> 1.6'
gem 'phony_rails', '~> 0.14'
gem 'enumerize', '~> 2.0'
gem 'httparty', '~> 0.14'
gem 'validates_overlap', '~> 0.8'
gem 'geokit-rails', '~> 2.2'
gem 'ffaker', '~> 2.5'

# Push notifications
gem 'houston', '~> 2.2'
gem 'gcm', '~> 0.1'

# Payments
gem 'alfabank', github: 'mendab1e/alfabank', branch: 'bindings'

# Monitoring
gem 'rollbar'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'annotate'
end

group :production do
  # AWS adapter for CarrierWave
  gem 'fog-aws', '~> 1.3'
  # Use Redis for caching and background jobs
  gem 'redis-rails', '~> 5.0'
end
