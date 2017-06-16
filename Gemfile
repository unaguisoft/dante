source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.15' # Use postgresql as the database for Active Record
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'kaminari'

gem 'sorcery', '~> 0.9.0'
gem 'draper', '~> 3.0.0.pre1' # Decorators
gem 'non-stupid-digest-assets'
gem 'prawn' # PDF Generator
gem 'prawn-table' # Tables for Prawn
gem 'prawn-icon' # Icons for Prawn
gem 'momentjs-rails', '>= 2.9.0' # Datetimepicker dependency
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37' # Datetimepicker
gem 'figaro'

# File uploader
gem "jquery-fileupload-rails"
gem 'dragonfly', '~> 1.0', '>= 1.0.12'
gem 'dragonfly-s3_data_store' # For using amazon in production

group :development, :test do
  gem 'pry'
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 3.0'
  gem 'spring'
  gem 'annotate' # Muestra los campos de la BD en los modelos
  gem 'hirb' # Mejora la visualización de consultas desde consola
  gem 'letter_opener'
end

group :test do
  gem 'minitest-reporters'
  gem 'rails-controller-testing'
end

group :production do
  gem 'rack-cache', require: 'rack/cache'
end

