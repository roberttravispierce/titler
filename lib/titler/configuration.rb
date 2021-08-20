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
      @admin_name = "Admin"
      @admin_controller = AdminController
      @app_name_position = "append" # append, prepend, none
      @use_env_prefix = true
      @use_app_tagline = true
      @delimiter = " - " # Note: (Eventually) a 'titler.delimiter' i18n value will override this
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
