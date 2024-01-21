require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EcommerceRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # action cable config
    # config.middleware.use ActionCable.server, mount_path: '/cable'
    
    # ActiveSupport.on_load(:before_initialize) do |app|
    #   app.config.middleware.insert_before(::Rack::Sendfile, ::EcommerceRails::AssumeSSL)
    # end

    # class EcommerceRails::AssumeSSL
    #   def initialize(app)
    #     @app = app
    #   end

    #   def call(env)
    #     env["HTTPS"] = "on"
    #     env["HTTP_X_FORWARDED_PORT"] = 443
    #     env["HTTP_X_FORWARDED_PROTO"] = "https"
    #     env["rack-url_scheme"] = "https"

    #     @app.call(env)
    #   end
    # end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
