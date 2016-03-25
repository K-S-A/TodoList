require File.expand_path('../boot', __FILE__)

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TodoList
  class Application < Rails::Application
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # # Bower asset paths
    # root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
    #   config.sass.load_paths << bower_path
    #   config.assets.paths << bower_path
    # end
    # # Precompile Bootstrap fonts
    # config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)
    # config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    # # Minimum Sass number precision required by bootstrap-sass
    # ::Sass::Script::Number.precision = [8, ::Sass::Script::Number.precision].max
#    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
#    config.assets.paths << Rails.root.join('bootstrap-sass', 'assets')
    # For Bootstrap Sass
 #  config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.woff *.ttf *.svg *.eot)
  end
end
