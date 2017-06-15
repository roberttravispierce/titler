require File.expand_path("../lib/titler/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name         = "titler"
  spec.version      = Titler::VERSION
  spec.authors      = ["Robert Pierce"]
  spec.email        = ["roberttravispierce@gmail.com"]
  spec.summary      = "A gem that make titling your Rails app pages dead simple but still allows you flexibility and control."
  spec.description = %q{
    Titler is a ruby gem that make titling your Rails app pages dead simple but still allows you flexibility and control. Set specific page titles in the controller or view with fallbacks for all situations. You can add environment and namespace prefixes (e.g. "Admin | <Title of page>") automatically.
  }
  spec.homepage     = "https://github.com/roberttravispierce/titler"
  spec.license      = "MIT"
  spec.files        = `git ls-files -z`.split("\x0")
  spec.test_files   = spec.files.grep(/\Aspec\//)
  spec.require_path = "lib"

  spec.required_ruby_version = "~> 2.0"

  # spec.add_dependency "activesupport", ">= 4.0"
  # spec.add_development_dependency "railties", ">= 4.0"
  # spec.add_development_dependency "actionmailer"
  # spec.add_development_dependency "rspec-rails", "~> 3.0"
end
