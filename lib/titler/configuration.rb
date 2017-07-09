class AdminController; end

module Titler
  class Configuration
    attr_accessor :admin_name,
                  :admin_controller,
                  :app_name_position,
                  :use_env_prefix,
                  :use_app_tagline,
                  :delimiter

    def initialize
      @admin_name = 'Admin'
      @admin_controller = AdminController
      @app_name_position = 'append' # append, prepend, none
      @use_env_prefix = true
      @use_app_tagline = true
      @delimiter = ' - ' #Note: a 'titler.delimiter' i18n value will override this
    end
  end

  # @return [Titler::Configuration] Titler's current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Set Titler's configuration
  # @param config [Titler::Configuration]
  def self.configuration=(config)
    @configuration = config
  end

  # Modify Titler's current configuration
  # @yieldparam [Titler::Configuration] config current Titler config
  # ```
  # Titler.configure do |config|
  #   config.use_env_prefix = false
  # end
  # ```
  def self.configure
    yield configuration
  end
end
