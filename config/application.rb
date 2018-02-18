require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Payermusic
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Tokyo'
    config.active_job.queue_adapter = :delayed_job
  end
end

#spotify
#RSpotify::authenticate("64c53ef52397425abe86863d281d25fb", "8c91939166924e51a0ef100fa54a6d1f")

