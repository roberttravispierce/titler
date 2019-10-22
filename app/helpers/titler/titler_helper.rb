# frozen_string_literal: true

# Main module for the gem
module Titler
  # Helper module for the gem
  module TitlerHelper
    def page_title(page_title)
      content_for(:page_title) { page_title }
    end

    def titler(custom_vars = {})
      context = controller.view_assigns.merge(custom_vars).symbolize_keys
      Title.new(
        controller: controller,
        i18n: I18n,
        title_as_set: content_for(:page_title) || @page_title,
        context: context
      ).to_s
    end

    # Main class for the gem
    class Title
      def initialize(controller:, i18n:, title_as_set:, context:)
        @controller = controller
        @i18n = i18n
        @title_as_set = title_as_set
        @context = context
        @configuration = Titler.configuration
      end

      def to_s
        titler = {}
        titler[:env_prefix] = env_prefix
        titler[:admin_namespace] = admin_namespace
        titler[:title_body] = title_body
        titler[:app_name] = app_name
        titler[:app_tagline] = app_tagline
        build_title_str(titler)
      end

      private

      def env_prefix
        if @configuration.use_env_prefix
          Rails.env.production? ? '' : "(#{Rails.env[0, 1].upcase}) "
        else
          ''
        end
      end

      def admin_namespace
        admin_namespace? ? admin_default_name + delimiter : ''
      end

      def admin_namespace?
        @controller.class.ancestors.include?(@configuration.admin_controller)
      end

      def admin_default_name
        @configuration.admin_name
      end

      def delimiter
        if @i18n.exists?('titler.delimiter') &&
           @i18n.t('titler.delimiter').present?
          @i18n.t('titler.delimiter')
        else
          @configuration.delimiter
        end
      end

      def app_name
        if @i18n.exists?('titler.app_name') &&
           @i18n.t('titler.app_name').present?
          @i18n.t('titler.app_name')
        else
          Rails.application.class.to_s.split('::').first
        end
      end

      def app_tagline
        @i18n.exists?('titler.app_tagline') ? @i18n.t('titler.app_tagline') : ''
      end

      def title_body
        if @title_as_set.present?
          @title_as_set
        else
          "#{controller_str} #{action_name_str}"
        end
      end

      def build_title_str(titler)
        if @configuration.app_name_position
          title_str_options(titler)[@configuration.app_name_position]
        else
          titler[:env_prefix] +
            titler[:admin_namespace] +
            titler[:title_body] +
            app_tagline_str(titler)
        end
      end

      def title_str_options(titler) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        { 'append' => titler[:env_prefix] +
          titler[:admin_namespace] +
          titler[:title_body] +
          app_tagline_str(titler) +
          app_name_str(titler),
          'prepend' => titler[:env_prefix] +
            app_name_str(titler) +
            app_tagline_str(titler) +
            titler[:admin_namespace] +
            titler[:title_body],
          '' => '' }.freeze
      end

      def app_name_str(titler)
        if title_body.blank?
          titler[:app_name]
        else
          app_name_position_options(titler)[@configuration.app_name_position]
        end
      end

      def app_name_position_options(titler)
        { 'append' => delimiter + titler[:app_name],
          'prepend' => titler[:app_name] + delimiter,
          '' => '' }.freeze
      end

      def app_tagline_str(titler)
        tagline = titler[:app_tagline]
        if tagline.blank? || !@configuration.use_app_tagline
          ''
        else
          app_tagline_options(tagline)[@configuration.app_name_position]
        end
      end

      def app_tagline_options(tagline)
        { 'append' => delimiter + tagline,
          'prepend' => tagline + delimiter }.freeze
      end

      def controller_str
        @controller.controller_name.titleize
      end

      def action_name_str
        @controller.action_name.titleize
      end
    end
  end
end
