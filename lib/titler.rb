app = File.expand_path("../../app", __FILE__)
$LOAD_PATH.unshift(app) unless $LOAD_PATH.include?(app)

require "titler/version"
require "rails/engine"
require "titler/engine"
require "titler/configuration"
require "helpers/titler/titler_helper"
