source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.1'

gem 'activeadmin'
gem 'active_model_serializers'
gem 'apipie-rails'
gem 'aws-sdk', '~> 2.3'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
#provide nested forms
gem 'cocoon', '~> 1.2', '>= 1.2.10'
gem 'coffee-rails', '~> 4.2'
gem 'compass-rails'
gem 'devise', '~> 4.2'
gem 'dotenv-rails'
gem 'draper'
gem 'friendly_id', '~> 5.2', '>= 5.2.3'
gem 'graphql'
gem 'graphiql-rails'
gem 'haml-rails'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jquery-turbolinks'
gem 'jwt'
#provide pagination
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'paperclip', '~> 5.1'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.2'
gem 'sass-rails', '~> 5.0'
gem 'simple_form', '~> 3.5'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolink
gem 'turbolinks', '~> 5'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem "font-awesome-rails"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'rspec-rails', '~> 3.6'
  gem 'rubocop', require: false
  gem 'selenium-webdriver'
  gem 'sqlite3'
end

group :test do
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
end

group :development do
  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  #provide RailsPanel in Chrome
  gem 'meta_request'
  gem 'pry-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'graphiql-rails', group: :development
