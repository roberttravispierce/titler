require 'rails/generators/base'

module Titler
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_titler_initializer
        copy_file 'titler.rb', 'config/initializers/titler.rb'
      end

    end
  end
end
