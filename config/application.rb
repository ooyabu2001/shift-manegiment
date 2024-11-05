require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShiftManagement
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
   
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
     config.time_zone = 'Tokyo' #日本時間に設定
      config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")　#アプリ内の時間範囲などをデーターベースで操作
    config.i18n.default_locale = :ja  #日本語に設定

     config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s] #複数のローカルファイル読み込み

    config.action_mailer.default_url_options = { host: 'example.com'}
  end
end
