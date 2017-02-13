source 'https://rubygems.org'

ruby '~> 2.4.0'

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'jbuilder', '~> 2.6'

# Auth
gem 'bcrypt'
gem 'has_secure_token'
gem 'devise'
gem 'devise-bootstrap-views'
gem 'pundit'

# Front end
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'

gem 'bootstrap-sass', '~> 3.3'
gem 'nested_form_fields', '~> 0.8'
gem 'bootstrap-datepicker-rails', '~> 1.6'

# Image processing
gem 'carrierwave', '~> 0.11'
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

# Push notifications
gem 'rpush', '~> 2.7'
gem 'net-http-persistent', '~> 2.9' # FIXME: fixed in master, wait for new version

# Payments
gem 'alfabank', github: 'mendab1e/alfabank', branch: 'bindings'

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
  gem 'rails_12factor'
  gem 'fog-aws', '~> 0.13'
end

gem 'ffaker', group: [:development, :staging]
