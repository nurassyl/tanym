require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"
require "active_support/core_ext/numeric/bytes"
require "active_support/core_ext/numeric/time"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tanym
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.cache_store = :redis_cache_store, {
      # url: "redis://:#{ENV.fetch('REDIS_PASSWORD')}@redis:6379/2",
      # Optional timeouts (seconds)
      # connect_timeout: 1.0,
      # read_timeout: 1.5,
      # write_timeout: 1.5,
      # Optional pool (for Puma/Sidekiq)
      # pool: {
      #  size: Integer(ENV.fetch("RAILS_MAX_THREADS", 5)),
      #  timeout: 5
      # },
      pool: $redis,
      namespace: "#{ENV.fetch('APP_NAME', 'app_name').downcase}:cache",
      error_handler: ->(method:, returning:, exception:) {
        Rails.logger.warn("RedisCacheStore error: #{method} -> #{exception.class}: #{exception.message}")
      },
      expires_in: 90.minutes,
      compress: true,
      compress_threshold: 2.kilobytes,
      skip_nil: true
    }
  end
end
