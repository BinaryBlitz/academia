source 'https://rubygems.org'

ruby '~> 2.3.3'

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
gem 'bootstrap-sass'
gem 'nested_form_fields'
gem 'bootstrap-datepicker-rails'

# Image processing
gem 'carrierwave'
gem 'mini_magick'

# I18n
gem 'rails-i18n'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'kaminari-i18n'

# Utilities
gem 'kaminari'
gem 'email_validator'
gem 'phony_rails'
gem 'enumerize'
gem 'httparty'
gem 'validates_overlap'
gem 'geokit-rails'

# Push notifications
gem 'rpush'
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
end

group :production do
  gem 'rails_12factor'
  gem 'fog-aws'
end

gem 'ffaker', group: [:development, :staging]
