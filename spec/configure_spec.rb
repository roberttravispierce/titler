require 'spec_helper'
require 'titler'

module Titler
  describe Configuration do

    context 'with configuration block' do
      it 'returns the use_env_prefix' do
        expect(Titler.configuration.use_env_prefix).to be true
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
