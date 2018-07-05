require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lovedaddy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.orm :active_record
      g.assets false
      g.template_engine :slim
      g.helper false
      g.jbuilder false
      g.test_framework :rspec,
        model_specs: true,
        view_specs: false,
        controller_specs: true,
        helper_specs: false,
        routing_specs: false,
        request_specs: false,
        integration_tool: false,
        fixture: true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    config.autoload_paths += %W(
      #{config.root}/app/models/active_hash
    )

    # アプリとしての表示タイムゾーン設定
    config.time_zone = 'Tokyo'

    # DB内に保存させる時間をOSのTimeZoneに合わせる
    config.active_record.default_timezone = :local

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
  end
end
