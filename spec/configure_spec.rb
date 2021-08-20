require "spec_helper"
require "titler"

class ManagerController; end

module Titler
  describe Configuration do
    context "with configuration block" do
      it "uses the options in the configuration block instead of defaults" do
        Titler.configure do |config|
          config.admin_controller = ManagerController
          config.admin_name = "Manager"
          config.app_name_position = "prepend"
          config.delimiter = " | "
          config.use_app_tagline = false
          config.use_env_prefix = false
        end

        expect(Titler.configuration.admin_controller).to eq ManagerController
        expect(Titler.configuration.admin_name).to eq "Manager"
        expect(Titler.configuration.app_name_position).to eq "prepend"
        expect(Titler.configuration.delimiter).to eq " | "
        expect(Titler.configuration.use_app_tagline).to eq false
        expect(Titler.configuration.use_env_prefix).to eq false
      end
    end

    describe "#configure" do
      it "sets use_env_prefix to true" do
        config = Configuration.new
        expect(config.use_env_prefix).to be true
      end

      it "can set use_env_prefix to false" do
        config = Configuration.new
        allow(config).to receive(:use_env_prefix).and_return(false)
        expect(config.use_env_prefix).to be false
      end

      after :each do
        Titler.reset
      end
    end
  end
end
