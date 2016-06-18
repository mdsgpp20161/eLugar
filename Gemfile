source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'capybara'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
gem 'omniauth-facebook'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'will_paginate'
gem 'bootstrap-will_paginate', '0.0.10'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem "prawn", "0.8.4"

gem 'wkhtmltopdf-binary'

gem 'wicked_pdf'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use Unicorn as the app server
# gem 'unicorn'
  
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'mocha'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
end

# group :test do
  # gem 'cucumber-rails', :require => false
#   # database_cleaner is not required, but highly recommended
#   gem 'database_cleaner'

#   gem 'rspec'

# end

gem 'simplecov', :require => false, :group => :test
gem 'selenium-webdriver'
gem 'launchy'
group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "rspec"

  gem 'bootstrap-sass', '~>3.2.0'
  gem 'autoprefixer-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
	gem 'spring-commands-rspec'
	gem 'spring-commands-cucumber'
end

group :test, :cucumber do
	gem 'pdf-reader'
end
gem 'devise'
gem "js-routes"