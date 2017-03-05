ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include MockLogin, type: :controller

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.use_transactional_fixtures = false

  config.before(:suite) do
    begin
      DatabaseCleaner.start
    # Test factories in spec/factories are working.
    # 有些 model 里面的验证是读取其他表, lint 会有问题; 报错信息的 formatter 也有问题
    # FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before(:each) do |_example|
    # TODO.md: 全局 mock
    allow_any_instance_of(Object).to receive(:sleep).with(any_args)
    allow(QiniuUtil).to receive(:upload2qiniu).with(any_args)
    allow(QiniuUtil).to receive(:deleteQiniuRqrcode).with(any_args)
    allow(QiniuUtil).to receive(:deleteQiniuPhoto).with(any_args)

    # 清理数据库
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do |_example|
    DatabaseCleaner.clean
  end
end
