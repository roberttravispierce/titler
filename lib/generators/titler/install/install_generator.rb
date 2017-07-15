require 'rails/generators/base'

module Titler
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc "Creates Titler initializer for your application"

      def copy_initializer
        template 'titler.rb', 'config/initializers/titler.rb'

        puts "Install complete!"
      end
    end
  end
end
