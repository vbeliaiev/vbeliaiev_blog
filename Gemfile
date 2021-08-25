source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4.rc1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Bootstrap
gem 'bootstrap', '~> 5.1.0'
#gem 'bootstrap_form'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use slim instead of erb
gem 'slim-rails'
gem 'popper_js', '~> 2.9.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# HTML editor
gem 'tinymce-rails'

# Truncate html
gem 'htmlentities'
gem 'nokogiri'
gem 'truncate_html'

# Social buttons
gem 'social-share-button'

# Authentication
gem 'sorcery'

# Authorization
gem 'pundit'

# Paginate
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap4'

# Image uploader
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'

group :development, :test do
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano3-puma',   require: false

  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'pry-remote'

  gem 'factory_girl_rails'
  gem 'ffaker'
end

group :development do
  gem 'listen'
  gem 'rubocop', '~> 0.49.1', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 4.0'
end
