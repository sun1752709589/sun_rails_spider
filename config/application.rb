require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SunRailsSpider
  class Application < Rails::Application
    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'
    config.active_record.raise_in_transactional_callbacks = true
    config.encoding = "utf-8"
    # Enable the asset pipeline
    config.assets.enabled = true
    config.i18n.default_locale = 'zh-CN'  
    config.generators do |g| 
      g.template_engine :haml
    end
  end
end