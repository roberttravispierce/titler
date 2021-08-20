require "coveralls"
Coveralls.wear!

require "bundler/setup"
require "pry"
require "titler"
require "rails"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.after(:each) { I18n.locale = :en }

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
