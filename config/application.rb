require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cup
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :zh
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.qiniu_download_url = "http://olzjsogr4.bkt.clouddn.com"
    config.qiniu_bucket = "meedisedy-users"

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,             #为各模型生成测试固件
                       view_specs: false,       #不生成“视图测试”
                       helper_specs: false,    #生成控制器时不生成对应的帮助方法测试文件
                       routing_specs: false,   #不生成针对 config/routes.rb 的测试文件
                       controller_specs: true,
                       request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.assets.precompile << Proc.new do |path|
      if path =~ /\.(css|js|scss|png|jpg|gif|json)\z/
        full_path = Rails.application.assets.resolve(path).to_path
        app_assets_path1 = Rails.root.join('app', 'assets').to_path
        app_assets_path2 = Rails.root.join('public', 'assets').to_path
        app_assets_path3 = Rails.root.join('vendor', 'assets').to_path


        if full_path.starts_with? app_assets_path1
          true
        else
          if full_path.starts_with? app_assets_path2
            true
          else
            if full_path.starts_with? app_assets_path3
              true
            else
              false
            end
          end
        end
      end
    end
  end
end
