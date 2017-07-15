require 'spec_helper'
require 'titler'

describe Titler::TitlerHelper do

# Defaults Only Context ----------------------------------------------------
  context 'when no title info is set' do
    it '(1) uses defaults' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({})

      expected_title = "#{env_prefix}#{controller.controller_name.titleize} #{controller.action_name.titleize} - #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end

    it '(2) prefixes defaults in development' do
      controller = MockController.new
      stub_rails(controller, 'development', nil)
      load_translations({})

      expected_title = "#{env_prefix}#{controller.controller_name.titleize} #{controller.action_name.titleize} - #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end

    it '(3) adds admin namespace to defaults' do
      controller = MockAdminController.new
      stub_rails(controller, 'production', nil)
      load_translations({})

      expected_title = "#{env_prefix}Admin - #{controller.controller_name.titleize} #{controller.action_name.titleize} - #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end
  end

# i18n Values Context ----------------------------------------------------
  context 'when titler i18n values exist' do
    it '(1) adds delimiter to defaults' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({ delimiter: ' | ' })

      expected_title = "#{env_prefix}#{controller.controller_name.titleize} #{controller.action_name.titleize} | #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end

    it '(2) used config delimiter if i18n.t is blank' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({ delimiter: '' })

      expected_title = "#{env_prefix}#{controller.controller_name.titleize} #{controller.action_name.titleize} - #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end

    it '(3) adds app name to defaults' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({ app_name: 'Test App' })

      expected_title = "#{env_prefix}#{controller.controller_name.titleize} #{controller.action_name.titleize} - Test App"
      expect(titler_helper.titler).to eq(expected_title)
    end

    it '(4) uses default app name if i18n.t is blank' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({ app_name: '' })

      expected_title = "#{env_prefix}#{controller.controller_name.titleize} #{controller.action_name.titleize} - #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end

    it '(5) adds tagline to defaults' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({ app_tagline: 'All the News' })

      expected_title = "#{env_prefix}#{controller.controller_name.titleize} #{controller.action_name.titleize} - All the News - #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end
  end

# Specific Page Title Context ----------------------------------------------------
  context 'when specific page title exists' do
    it '(1) uses page_title var when present' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({})
      titler_helper.instance_variable_set(:@page_title, 'Var Test Page')
      expected_title = "#{env_prefix}Var Test Page - #{app_name}"
      expect(titler_helper.titler).to eq(expected_title)
    end

    # it '(1) uses content_for when present' do
    #   controller = MockController.new
    #   stub_rails(controller, 'production', nil)
    #   #TODO setting the content_for is not working for some reason
    #   titler_helper.content_for(:page_title, 'Test Page')
    #   expected_title = "#{env_prefix}Test Page - #{app_name}"
    #   expect(titler_helper.titler).to eq(expected_title)
    # end
  end

# Configuration Values Context ----------------------------------------------------
  context 'when titler configuration values exist' do
    it 'uses the options in the configuration block instead of defaults' do
      controller = MockController.new
      stub_rails(controller, 'production', nil)
      load_translations({})

      Titler.configure do |config|
        config.delimiter = ' | '
      end

      expect(titler_helper.titler).to include('|')

      Titler.reset
    end
  end

  def stub_rails(controller, env_str, content_for)
    allow(Rails).to receive_message_chain(:application, :class).and_return('TitlerTest::Application')
    allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new(env_str))
    allow(Rails).to receive(:controller).and_return(controller)

    allow(titler_helper).to receive_message_chain(:content_for).and_return(content_for)
    allow(titler_helper).to receive_message_chain(:controller, :view_assigns).and_return({})
    allow(titler_helper).to receive_message_chain(:controller).and_return(controller)
  end

  def app_name
    Rails.application.class.to_s.split("::").first
  end

  def load_translations(titles)
    I18n.backend.reload!
    I18n.backend.store_translations(:en, { titler: titles })
  end

  def env_prefix
    Rails.env.production? ? '' : "(#{Rails.env[0,1].upcase}) "
  end

  # TODO: I think there's a way to do away with this stub style and use something like:
  #       allow(helper).to receive(:controller).and_return('MockController') but I'm not sure.
  class MockController
    def controller_name
      "mock"
    end

    def action_name
      "action"
    end

    def view_assigns
      {}
    end
  end

  class AdminController; end
  class MockAdminController < AdminController
    def controller_name
      "mock_admin"
    end

    def action_name
      "action"
    end

    def view_assigns
      {}
    end
  end

  class MyAdminController < AdminController
    def controller_name
      "my_admin"
    end

    def action_name
      "action"
    end

    def view_assigns
      {}
    end
  end

  def titler_helper
    @titler_helper ||= Class.new { include Titler::TitlerHelper }.new
  end
end
