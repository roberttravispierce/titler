lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "titler/version"

Gem::Specification.new do |spec|
  spec.name = "titler"
  spec.version = Titler::VERSION
  spec.authors = ["Robert Travis Pierce", "Jonathan Allured"]
  spec.email = ["robert@roberttravispierce.com"]

  spec.summary = "Titler is a ruby gem that automaticaly gives you useful and consistent page titles for your Rails application."
  spec.description = "Titler is a ruby gem that automaticaly gives you useful and consistent page titles for your Rails application. You can set specific page titles in the controller or view with fallbacks and useful defaults for all situations."
  spec.homepage = "https://github.com/roberttravispierce/titler"
  spec.license = "MIT"
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.test_files = spec.files.grep(/\Aspec\//)
  spec.require_path = "lib"

  spec.required_ruby_version = ">= 2.6"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rb-readline"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "standard"

  spec.add_dependency "rails", ">= 5.2"
  spec.add_dependency "i18n"
end
