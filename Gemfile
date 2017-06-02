source 'https://gems.ruby-china.org'
# gem "rubyist-aasm", :source => "http://gems.github.com"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'ruby_parser', '~> 3.8', '>= 3.8.1'
# Use jquery as the JavaScript library
gem 'jquery-rails'  
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'execjs'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'devise', '4.2.0'
gem 'cancancan', '1.15.0'
gem 'rolify', '5.1.0'
gem 'mysql2', '0.4.5'
gem 'ransack', '1.8.2'
gem 'bootstrap_form', '2.5.3'

gem 'bcrypt-ruby', '3.1.5'
gem 'enum_help', '0.0.16'
gem 'devise-i18n', '1.1.1'
gem 'pjax_rails', '0.4.0'
gem "font-awesome-rails", '4.7.0.1'
gem "therubyracer", '0.12.3'
gem "less-rails", '2.8.0'
gem 'kaminari', '1.0.0'
gem 'sprockets', '3.6.3'
gem 'jquery-datetimepicker-rails', '2.4.1.0'
gem 'bootstrap-multiselect-rails', '0.9.9'
# 自动补全
gem 'rails4-autocomplete', '1.1.1'
gem 'jquery-ui-rails', '5.0.5'
gem "json", '1.8.3'
gem 'useragent', '0.16.8'
gem 'rubocop','0.46.0'
gem 'qwer', '0.1.7'
gem 'qiniu', '6.8.1'
gem 'rqrcode_png', '0.1.5'

gem 'mina'
gem 'puma'


group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'parallel_tests'

  gem 'bundler-audit'
  gem 'rails_best_practices'
  gem 'brakeman'

  gem 'rspec-kickstarter'

  gem 'byebug'

  gem 'traceroute'
end


group :test do
  #自动清除数据库数据的工具，每次运行完测试用例它就会自动清除数据库。
  gem 'database_cleaner'
  #为预构件生成名字、Email 地址以及其他的示例数据
  gem 'faker'
  #便于模拟用户和程序的交互操作
  gem 'capybara'
  #如果需要,它会打开系统的默认浏览器,显示应用程序当前渲染的页面
  gem 'launchy'
  #结合 Capybara 测试基于 JavaScript 的交互操作
  gem 'selenium-webdriver'

  gem 'simplecov', require: false
  gem 'webmock', require: false
  gem 'fakeweb', require: false
  # gem 'net-http-persistent', '~> 3.0.0'
  gem 'vcr', require: false
  gem "fakeredis", require: "fakeredis/rspec"
  gem 'timecop'
end

