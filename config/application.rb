require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RegulationLib
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.action_mailer.default_url_options = {host: 'localhost', port: '3000'}

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      "#{html_tag}".html_safe
    }

    # config.hosts << "60b4-5-165-230-212.ngrok-free.app"
    config.hosts << "3db7-5-165-230-212.ngrok-free.app"

    # I18n configs (from crm configs)
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{yml}').to_s]
    I18n.available_locales = [:en, :ru] # разрешенные локали, доступные приложению
    I18n.default_locale = :ru # устанавливаем локаль по умолчанию
    I18n.reload!
  end
end
