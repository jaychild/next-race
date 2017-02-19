require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NextRace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application config should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << Rails.root.join('lib')

    # insures apis start as 'disabled'
    config.after_initialize do
      Config::RaceApi.all.each do |api|
        api.live_update = false
        api.save
      end

    end
  end
end
