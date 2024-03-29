require "rails/generators/base"

module Titler
  module Generators
    class LocalesGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../..", __FILE__)

      def create_locales
        locales.each do |locale|
          copy_file locale
        end
      end

      private

      def locales
        files_within_root(".", "config/locales/**/*.*")
      end

      def files_within_root(prefix, glob)
        root = "#{self.class.source_root}/#{prefix}"

        Dir["#{root}/#{glob}"].sort.map do |full_path|
          full_path.sub(root, ".").gsub("/./", "/")
        end
      end
    end
  end
end
