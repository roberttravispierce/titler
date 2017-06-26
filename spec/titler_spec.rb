require "spec_helper"

class MockController
  def controller_name
    "mock"
  end

  def action_name
    "action"
  end
end

class AdminController; end
class MockAdminController < AdminController
  def controller_name
    "mock"
  end

  def action_name
    "action"
  end
end

module Rails
  def application
    def class
      "TestApp::Application"
    end
  end
end

RSpec.describe Titler do
  describe '#title' do
    before :all do
      i18n = double(:i18n)
    end

  # Test default setup ----------------------------------------------------
    context 'when no title info provided by app' do
      it 'returns the title from defaults' do
        mock_controller = MockController.new
        i18n = double(:i18n)
        allow(i18n).to receive(:exists?).with('titler.admin_name').and_return false
        allow(i18n).to receive(:exists?).with('titler.delimiter').and_return false
        allow(i18n).to receive(:exists?).with('titler.app_name').and_return false
        allow(i18n).to receive(:exists?).with('titler.app_tagline').and_return false
        app_name = Rails.application.class.to_s.split("::").first
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development'))
        env_prefix = '(D)'
        expected_title = "#{env_prefix} #{mock_controller.controller_name.titleize} #{mock_controller.action_name.titleize} - #{app_name}"
        title = Titler.new(controller: mock_controller, i18n: i18n, title_as_set: '').title
        expect(title).to eq expected_title
      end
    end

  # Test i18n values only setup ----------------------------------------------------
    context 'when only i18n values provided by app' do
      it 'returns the title from i18n values' do
        mock_controller = MockController.new
        i18n = double(:i18n)
        allow(i18n).to receive(:exists?).with('titler.admin_name').and_return true
        allow(i18n).to receive(:t).with('titler.admin_name').and_return 'Admin'
        allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
        allow(i18n).to receive(:t).with('titler.delimiter').and_return ' - '
        allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
        allow(i18n).to receive(:t).with('titler.app_name').and_return 'Titler Demo App'
        allow(i18n).to receive(:exists?).with('titler.app_tagline').and_return true
        allow(i18n).to receive(:t).with('titler.app_tagline').and_return 'Test Tagline'
        app_name = i18n.t('titler.app_name')
        app_tagline = i18n.t('titler.app_tagline')
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('staging'))
        env_prefix = '(S)'
        expected_title = "#{env_prefix} #{mock_controller.controller_name.titleize} #{mock_controller.action_name.titleize} - #{app_tagline} - #{app_name}"
        title = Titler.new(controller: mock_controller, i18n: i18n, title_as_set: '').title
        expect(title).to eq expected_title
      end
    end

  # Test admin_namespace ----------------------------------------------------
    context 'when in an admin namespace' do
      context 'and user sets the delimiter' do
        it 'returns the title with the correct admin prefix' do
          mock_controller = MockAdminController.new
          i18n = double(:i18n)
          allow(i18n).to receive(:exists?).with('titler.admin_name').and_return true
          allow(i18n).to receive(:t).with('titler.admin_name').and_return 'Admin'
          allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
          allow(i18n).to receive(:t).with('titler.delimiter').and_return ' - '
          allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
          allow(i18n).to receive(:t).with('titler.app_name').and_return 'TitlerTest'
          allow(i18n).to receive(:exists?).with('titler.app_tagline').and_return false
          title = Titler.new(controller: mock_controller, i18n: i18n, title_as_set: 'This page title set in view').title
          expect(title).to include 'Admin - '
        end
      end

      context 'and user does not set the delimiter' do
        it 'returns the title with the correct admin prefix' do
          mock_controller = MockAdminController.new
          i18n = double(:i18n)
          allow(i18n).to receive(:exists?).with('titler.admin_name').and_return true
          allow(i18n).to receive(:t).with('titler.admin_name').and_return 'Admin'
          allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
          allow(i18n).to receive(:t).with('titler.delimiter').and_return ' - '
          allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
          allow(i18n).to receive(:t).with('titler.app_name').and_return 'TitlerTest'
          allow(i18n).to receive(:exists?).with('titler.app_tagline').and_return false
          title = Titler.new(controller: mock_controller, i18n: i18n, title_as_set: '').title
          expect(title).to include 'Admin - '
        end
      end

      context 'and user sets the admin name' do
        it 'returns the title with the correct admin prefix' do
          mock_controller = MockAdminController.new
          i18n = double(:i18n)
          allow(i18n).to receive(:exists?).with('titler.admin_name').and_return true
          allow(i18n).to receive(:t).with('titler.admin_name').and_return 'MyAdmin'
          allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
          allow(i18n).to receive(:t).with('titler.delimiter').and_return ' - '
          allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
          allow(i18n).to receive(:t).with('titler.app_name').and_return 'TitlerTest'
          allow(i18n).to receive(:exists?).with('titler.app_tagline').and_return false
          title = Titler.new(controller: mock_controller, i18n: i18n, title_as_set: '').title
          expect(title).to include 'MyAdmin - '
        end
      end

      context 'and user does not set the admin name' do
        it 'returns the title with the correct admin prefix' do
          mock_controller = MockAdminController.new
          i18n = double(:i18n)
          allow(i18n).to receive(:exists?).with('titler.admin_name').and_return false
          # allow(i18n).to receive(:t).with('titler.admin_name').and_return 'Admin'
          allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
          allow(i18n).to receive(:t).with('titler.delimiter').and_return ' - '
          allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
          allow(i18n).to receive(:t).with('titler.app_name').and_return 'TitlerTest'
          allow(i18n).to receive(:exists?).with('titler.app_tagline').and_return false
          title = Titler.new(controller: mock_controller, i18n: i18n, title_as_set: '').title
          expect(title).to include 'Admin - '
        end
      end
    end

    context 'when in a non-admin namespace' do
      it 'returns the title without an admin prefix' do
        mock_controller = MockController.new
        i18n = double(:i18n)
        allow(i18n).to receive(:exists?).with('titler.admin_name').and_return true
        allow(i18n).to receive(:t).with('titler.admin_name').and_return 'Admin'
        allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
        allow(i18n).to receive(:t).with('titler.delimiter').and_return ' | '
        allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
        allow(i18n).to receive(:t).with('titler.app_name').and_return 'TitlerTest'
        allow(i18n).to receive(:exists?).with('titler.app_tagline').and_return false
        title = Titler.new(controller: mock_controller, i18n: i18n, title_as_set: '').title
        expect(title).not_to include 'Admin - '
      end
    end

  #   # context 'evaluates namespace as admin' do
  #   #   it '(1) returns a title prefixed by the admin namespace' do
  #   #     mock_controller = MockController.new
  #   #     expect(i18n).to receive(:exists?).with('titler.delimiter').and_return false
  #   #     title = Titler.new(controller: mock_controller, i18n: i18n).title
  #   #     # expect(title).to eq 'Admin - foo'
  #   #     expect(title).to include('Admin')
  #   #   end
  #   # end
  #
  #   # it '(1) return the env_prefix, admin namespace, content_for, delimiter and base if exists' do
  #   #   I18n.backend = I18n::Backend::Simple.new
  #   #   controller.stub(:controller_name).and_return('AdminController')
  #   #   @titler = 'This is a Test Page' #content_for takes precedence
  #   #   helper.content_for(:titler, 'Test Page')
  #   #   expected_title = "(T) #{admin_namespace}#{delimiter}Test Page#{delimiter}#{base}"
  #   #   expect(Titler.new.set).to eq(expected_title)
  #   # end
  #
  #   it '(1) returns a title' do
  #     title = Titler.new(controller: nil, i18n: nil).title
  #     expect(title).to eq 'foo'
  #   end
  #
  #   it '(2) returns a title prefixed by the admin namespace' do
  #     mock_controller = MockController.new
  #     i18n = double(:i18n)
  #     title = Titler.new(controller: mock_controller, i18n: i18n).title
  #     expect(title).to eq 'Admin - foo'
  #   end
  #
  #
  # # Test env_prefix ----------------------------------------------------
  #   context 'when in production environment' do
  #     it 'returns the title with no environment prefix' do
  #
  #     end
  #   end
  #
  #   context 'when not in production environment' do
  #     it 'returns the title with an environment prefix' do
  #     end
  #   end
  #
  # # Test admin_namespace ----------------------------------------------------
  #   context 'when in an admin namespace' do
  #     it 'returns the title with an admin prefix' do
  #       mock_controller = MockAdminController.new
  #       i18n = double(:i18n)
  #       allow(i18n).to receive(:exists?).with('titler.admin_name').and_return true
  #       allow(i18n).to receive(:t).with('titler.admin_name').and_return 'Admin'
  #       allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
  #       allow(i18n).to receive(:t).with('titler.delimiter').and_return ' - '
  #       allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
  #       allow(i18n).to receive(:t).with('titler.app_name').and_return 'TitlerTest'
  #       title = Titler.new(controller: mock_controller, i18n: i18n).title
  #       expect(title).to include 'Admin - '
  #     end
  #   end
  #
  #   context 'when in a non-admin namespace' do
  #     it 'returns the title without an admin prefix' do
  #       mock_controller = MockController.new
  #       i18n = double(:i18n)
  #       allow(i18n).to receive(:exists?).with('titler.admin_name').and_return true
  #       allow(i18n).to receive(:t).with('titler.admin_name').and_return 'Admin'
  #       allow(i18n).to receive(:exists?).with('titler.delimiter').and_return true
  #       allow(i18n).to receive(:t).with('titler.delimiter').and_return ' | '
  #       allow(i18n).to receive(:exists?).with('titler.app_name').and_return true
  #       allow(i18n).to receive(:t).with('titler.app_name').and_return 'TitlerTest'
  #       title = Titler.new(controller: mock_controller, i18n: i18n).title
  #       expect(title).not_to include 'Admin - '
  #     end
  #   end
  #
  # # Test delimiter ----------------------------------------------------
  #   context 'when a delimiter translation is present' do
  #     it 'returns the title using the delimiter from i18n' do
  #       mock_controller = MockController.new
  #       i18n = double(:i18n)
  #       expect(i18n).to receive(:exists?).with('titler.delimiter').and_return true
  #       expect(i18n).to receive(:t).with('titler.delimiter').and_return ' : '
  #       title = Titler.new(controller: mock_controller, i18n: i18n).title
  #       expect(title).to eq 'Admin : foo'
  #     end
  #   end
  #
  #   context 'when a delimiter translation is not present' do
  #     it 'returns the title using the default delimiter' do
  #     end
  #   end
  #
  # # Test as_set ----------------------------------------------------
  #   context 'when a page title is set in a content_for method' do
  #     it 'returns the title containing the content_for as _set value' do
  #     end
  #   end
  #
  #   context 'when a page title is set in an instance variable' do
  #     it 'returns the title containing the instance variable as_set value' do
  #     end
  #   end
  #
  #   context 'when a page title is not explicitely set' do
  #     it 'returns the title containing a blank as_set value' do
  #     end
  #   end

  end
end
