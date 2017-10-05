source 'https://rubygems.org'

ruby '2.2.3'
gem 'file_validators'
gem 'rails', '4.2.5.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
# gem 'unicorn'
gem 'mongoid'
gem 'mongoid-enum'
gem 'money-rails'
gem 'bson_ext'

gem 'carrierwave-mongoid'
gem 'fog-aws'

gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

gem 'recaptcha', require: 'recaptcha/rails'
gem 'certified'

gem 'chartkick'

gem 'puma'

gem 'ffaker'


group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'byebug'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'mongoid-rspec'
  gem 'capybara'
end

group :development do
# gem 'capistrano', '~> 2.15', '>= 2.15.9'
# gem 'rvm-capistrano', '~> 1.5', '>= 1.5.4'
  gem 'spring'
  gem 'web-console', '~> 2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'capistrano', '~> 3.5.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rvm', github: "capistrano/rvm"
