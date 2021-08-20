require "rails/generators/base"

module Titler
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Creates Titler initializer and i18n for your application"

      def copy_initializer
        template "titler.rb", "config/initializers/titler.rb"
        puts "Initializer install complete."
      end

      def copy_i18n
        template "titler.en.yml", "config/locales/titler.en.yml"
        puts "Localization install complete."
      end
    end
  end
end
