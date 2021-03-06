require_relative "boot"

require "rails/all"
#require 'csv'
require "dotenv-rails"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dots2021
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"

    config.time_zone = 'Central America'

    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.assets.enabled = true
    # config.eager_load_paths << Rails.root.join("extras")
    WeekOfMonth.configuration.monday_active = true

  end
end
